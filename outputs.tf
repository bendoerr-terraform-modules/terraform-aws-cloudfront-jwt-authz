output "id" {
  value       = module.label.id
  description = "The normalized ID from the 'bendoerr-terraform-modules/terraform-null-label' module."
}

output "tags" {
  value       = module.label.tags
  description = "The normalized tags from the 'bendoerr-terraform-modules/terraform-null-label' module."
}

output "name" {
  value       = var.name
  description = "The provided name given to the module."
}

output "lambda_function_arn" {
  description = "ARN of the deployed Lambda function"
  value       = module.lambda.lambda_function_arn
}

output "lambda_function_name" {
  description = "Name of the deployed Lambda function"
  value       = module.lambda.lambda_function_name
}

output "lambda_function_version" {
  description = "The published version of the Lambda function"
  value       = module.lambda.lambda_function_version
}

output "lambda_function_invoke_arn" {
  description = "The invoke ARN of the Lambda function"
  value       = module.lambda.lambda_function_invoke_arn
}

output "lambda_layers_arns" {
  description = "The ARNs of the Lambda layers attached to the function"
  value       = module.lambda.lambda_layers_arns
}

output "lambda_iam_role_arn" {
  description = "ARN of the IAM role attached to the Lambda function"
  value       = module.lambda.iam_role_arn
}

output "lambda_cloudwatch_log_group_name" {
  description = "The name of the CloudWatch Log Group for the Lambda function"
  value       = module.lambda.cloudwatch_log_group_name
}

output "lambda_cloudwatch_log_group_arn" {
  description = "The ARN of the CloudWatch Log Group for the Lambda function"
  value       = module.lambda.cloudwatch_log_group_arn
}
