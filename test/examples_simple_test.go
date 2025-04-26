package test_test

import (
	"encoding/json"
	"os"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/random"

	"github.com/aws/aws-sdk-go-v2/aws"
	"github.com/aws/aws-sdk-go-v2/config"
	"github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider"
	cognito_types "github.com/aws/aws-sdk-go-v2/service/cognitoidentityprovider/types"
	"github.com/aws/aws-sdk-go-v2/service/lambda"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/kr/pretty"
	"github.com/stretchr/testify/assert"
	"github.com/stretchr/testify/require"
)

func TestDefaults(t *testing.T) {
	// Setup terratest
	rootFolder := "../"
	terraformFolderRelativeToRoot := "examples/simple"

	tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, rootFolder, terraformFolderRelativeToRoot)

	terraformOptions := &terraform.Options{
		TerraformDir: tempTestFolder,
		Upgrade:      true,
		NoColor:      os.Getenv("CI") == "true",
		Vars: map[string]interface{}{
			"namespace": strings.ToLower(random.UniqueId()),
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Print out the Terraform Output values
	_, _ = pretty.Print(terraform.OutputAll(t, terraformOptions))
	outputs := terraform.OutputAll(t, terraformOptions)
	_, _ = pretty.Print(outputs)

	// AWS Session
	cfg, err := config.LoadDefaultConfig(
		t.Context(),
		config.WithRegion("us-east-1"),
	)

	if err != nil {
		t.Fatal(err)
	}

	// Create clients for Cognito and Lambda
	cognitoClient := cognitoidentityprovider.NewFromConfig(cfg)
	lambdaClient := lambda.NewFromConfig(cfg)

	// Get resource information from Terraform outputs
	userPoolID := outputs["user_pool_id"].(string)
	userPoolClientID := outputs["user_pool_client_id"].(string)
	lambdaFunctionName := outputs["lambda_function_name"].(string)

	// Create a test user in Cognito
	username := "testuser_" + strings.ToLower(random.UniqueId())
	email := username + "@example.com"
	tempPassword := "TempP@ssw0rd!" + random.UniqueId()
	permanentPassword := "Perm@nentP@ssw0rd!" + random.UniqueId()

	t.Logf("Creating test user: %s", username)
	_, err = cognitoClient.AdminCreateUser(t.Context(), &cognitoidentityprovider.AdminCreateUserInput{
		UserPoolId:        aws.String(userPoolID),
		Username:          aws.String(username),
		TemporaryPassword: aws.String(tempPassword),
		UserAttributes: []cognito_types.AttributeType{
			{
				Name:  aws.String("email"),
				Value: aws.String(email),
			},
			{
				Name:  aws.String("email_verified"),
				Value: aws.String("true"),
			},
		},
	})
	require.NoError(t, err, "Failed to create Cognito user")

	// Set a permanent password for the user
	t.Log("Setting permanent password for user")
	_, err = cognitoClient.AdminSetUserPassword(t.Context(), &cognitoidentityprovider.AdminSetUserPasswordInput{
		UserPoolId: aws.String(userPoolID),
		Username:   aws.String(username),
		Password:   aws.String(permanentPassword),
		Permanent:  true,
	})
	require.NoError(t, err, "Failed to set permanent password")

	// Authenticate the user to get an access token
	t.Log("Authenticating user to get access token")
	authResult, err := cognitoClient.InitiateAuth(t.Context(), &cognitoidentityprovider.InitiateAuthInput{
		AuthFlow: cognito_types.AuthFlowTypeUserPasswordAuth,
		ClientId: aws.String(userPoolClientID),
		AuthParameters: map[string]string{
			"USERNAME": username,
			"PASSWORD": permanentPassword,
		},
	})
	require.NoError(t, err, "Failed to authenticate user")

	accessToken := *authResult.AuthenticationResult.AccessToken
	t.Logf("Received access token: %s...", accessToken[:20])

	// Create a CloudFront Lambda@Edge event with the access token
	cloudFrontEvent := map[string]interface{}{
		"Records": []map[string]interface{}{
			{
				"cf": map[string]interface{}{
					"config": map[string]interface{}{
						"distributionId": "EXAMPLE",
					},
					"request": map[string]interface{}{
						"uri":      "/api/protected",
						"method":   "GET",
						"clientIp": "2001:0db8:85a3:0:0:8a2e:0370:7334",
						"headers": map[string]interface{}{
							"authorization": []map[string]interface{}{
								{
									"key":   "Authorization",
									"value": "Bearer " + accessToken,
								},
							},
						},
					},
				},
			},
		},
	}

	// Convert the event to JSON
	eventJSON, err := json.Marshal(cloudFrontEvent)
	require.NoError(t, err, "Failed to marshal CloudFront event")

	// Invoke the Lambda function with the event
	t.Log("Invoking Lambda function with CloudFront event")
	result, err := lambdaClient.Invoke(t.Context(), &lambda.InvokeInput{
		FunctionName: aws.String(lambdaFunctionName),
		Payload:      eventJSON,
	})
	require.NoError(t, err, "Failed to invoke Lambda function")

	// Check for Lambda execution errors
	require.Equal(t, int32(200), result.StatusCode, "Lambda invocation failed with status code %d", result.StatusCode)
	require.Nil(t, result.FunctionError, "Lambda function returned error: %s", result.FunctionError)

	// Parse the response
	var lambdaResponse map[string]interface{}
	err = json.Unmarshal(result.Payload, &lambdaResponse)
	require.NoError(t, err, "Failed to unmarshal Lambda response")

	// Verify the response is the original request (meaning authorization succeeded)
	// If authorization fails, the lambda would return a 401 response object instead
	t.Log("Verifying Lambda response indicates successful authorization")
	_, hasURI := lambdaResponse["uri"]
	assert.True(
		t,
		hasURI,
		"Expected response to contain original request with 'uri' field, indicating successful authorization",
	)

	t.Log("JWT Authorization test passed successfully")
}
