output "id" {
  value       = module.this.id
  description = "The normalized ID from the 'bendoerr-terraform-modules/terraform-null-label' module."
}

output "tags" {
  value       = module.this.tags
  description = "The normalized tags from the 'bendoerr-terraform-modules/terraform-null-label' module."
}

output "name" {
  value       = module.this.name
  description = "The provided name given to the module."
}

output "user_pool_id" {
  value       = aws_cognito_user_pool.example.id
  description = "The ID of the Cognito User Pool"
}

output "user_pool_client_id" {
  value       = aws_cognito_user_pool_client.example.id
  description = "The ID of the Cognito User Pool Client"
}

output "lambda_function_arn" {
  description = "ARN of the deployed Lambda function"
  value       = module.this.lambda_function_arn
}

output "lambda_function_name" {
  description = "Name of the deployed Lambda function"
  value       = module.this.lambda_function_arn
}

output "lambda_function_version" {
  description = "The published version of the Lambda function"
  value       = module.this.lambda_function_version
}

output "lambda_function_invoke_arn" {
  description = "The invoke ARN of the Lambda function"
  value       = module.this.lambda_function_invoke_arn
}

output "lambda_layers_arns" {
  description = "The ARNs of the Lambda layers attached to the function"
  value       = module.this.lambda_layers_arns
}

output "lambda_iam_role_arn" {
  description = "ARN of the IAM role attached to the Lambda function"
  value       = module.this.lambda_iam_role_arn
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the CloudWatch Log Group for the Lambda function"
  value       = module.this.lambda_cloudwatch_log_group_name
}

output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for the Lambda function"
  value       = module.this.lambda_cloudwatch_log_group_arn
}
