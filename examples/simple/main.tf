terraform {
  # Anything greater than the 1.0.0 release should be sufficient
  required_version = ">= 1.0.0"

  required_providers {
    # Use a v5.x.x version of the AWS provider
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.20"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Use the module with Cognito JWT configuration
module "this" {
  source  = "../.."
  context = module.context.shared
  name    = "simple"

  # Configure JWT parameters from Cognito
  jwt_issuer   = "https://cognito-idp.${module.context.region}.amazonaws.com/${aws_cognito_user_pool.example.id}"
  jwt_audience = "" # Cognito doesn't set an audience on access tokens
  jwt_jwks_url = "https://cognito-idp.${module.context.region}.amazonaws.com/${aws_cognito_user_pool.example.id}/.well-known/jwks.json"
}

# -----
# Supporting Resources

module "label" {
  source  = "bendoerr-terraform-modules/label/null"
  version = "0.5.0"
  context = module.context.shared
  name    = "simple-authz"
}

# Create a Cognito User Pool for authentication
resource "aws_cognito_user_pool" "example" {
  name = "${module.label.id}-user-pool"

  password_policy {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }

  schema {
    name                = "email"
    attribute_data_type = "String"
    required            = true
    mutable             = true
  }

  admin_create_user_config {
    allow_admin_create_user_only = true
  }
}

# Create a domain for the user pool
resource "aws_cognito_user_pool_domain" "example" {
  domain       = "${module.label.id}-domain"
  user_pool_id = aws_cognito_user_pool.example.id
}

# Create a client app for the user pool
resource "aws_cognito_user_pool_client" "example" {
  name                          = "${module.label.id}-client"
  user_pool_id                  = aws_cognito_user_pool.example.id
  generate_secret               = false
  refresh_token_validity        = 30
  prevent_user_existence_errors = "ENABLED"
  explicit_auth_flows = [
    "ALLOW_REFRESH_TOKEN_AUTH",
    "ALLOW_USER_PASSWORD_AUTH",
    "ALLOW_ADMIN_USER_PASSWORD_AUTH"
  ]
  allowed_oauth_flows          = ["code", "implicit"]
  allowed_oauth_scopes         = ["openid", "email", "profile"]
  callback_urls                = ["https://example.com/callback"]
  logout_urls                  = ["https://example.com/logout"]
  supported_identity_providers = ["COGNITO"]
}
