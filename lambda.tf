# tfsec:ignore:AVD-AWS-0066 # Lambda@Edge doesn't support tracing
module "lambda" {
  source  = "bendoerr-terraform-modules/lambda/aws"
  version = "0.1.2"
  context = var.context
  name    = var.name

  description      = "Authorize CloudFront HTTP Request with Lambda@Edge"
  filename         = data.archive_file.lambda_source.output_path
  source_code_hash = data.archive_file.lambda_source.output_base64sha256
  handler          = "index.handler"
  runtime          = "nodejs22.x"
  publish          = true

  addl_assume_role_policy_principles = [
    "edgelambda.amazonaws.com"
  ]

  depends_on = [
    null_resource.build_lambda,
    data.archive_file.lambda_source
  ]
}

resource "aws_lambda_permission" "allow_cloudfront" {
  statement_id  = "AllowExecutionFromCloudFront"
  action        = "lambda:GetFunction"
  function_name = module.lambda.lambda_function_name
  principal     = "edgelambda.amazonaws.com"
  source_arn    = var.cloudfront_distribution_arn != null ? var.cloudfront_distribution_arn : "arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/*"
}

# Get current AWS account ID
data "aws_caller_identity" "current" {}
