resource "null_resource" "build_lambda" {
  provisioner "local-exec" {
    command = <<EOT
      # Check if npm is available
      #if ! command -v npm &> /dev/null; then
      #  echo "npm is not installed. Please install Node.js and npm."
      #  exit 1
      #fi

      # Set environment variables and install dependencies
      export JWT_ISSUER=${var.jwt_issuer}
      export JWT_AUDIENCE=${var.jwt_audience}
      export JWT_JWKS_URI=${var.jwt_jwks_url}

      # Navigate to the Lambda source directory
      cd ${path.module}/lambda/authz-js

      # Install dependencies
      npm ci || npm install
      if [ $? -ne 0 ]; then
        echo "Failed to install dependencies"
        exit 1
      fi

      # Run the build script
      npm run build
      if [ $? -ne 0 ]; then
        echo "Failed to build Lambda function"
        exit 1
      fi
    EOT
  }

  triggers = {
    # Trigger a rebuild when the source file or env variables changes
    index_ts      = filemd5("${path.module}/lambda/authz-js/index.ts")
    package_json  = filemd5("${path.module}/lambda/authz-js/package.json")
    build_js      = filemd5("${path.module}/lambda/authz-js/build.js")
    tsconfig_json = filemd5("${path.module}/lambda/authz-js/tsconfig.json")
    JWT_ISSUER    = var.jwt_issuer
    JWT_AUDIENCE  = var.jwt_audience
    JWT_JWKS_URI  = var.jwt_jwks_url
  }
}

# Create a more consistent hash for the Lambda function
data "archive_file" "lambda_source" {
  type        = "zip"
  source_file = "${path.module}/lambda/authz-js/dist/index.cjs"
  output_path = "${path.module}/lambda/authz-js/dist/lambda-deployment.zip"
  depends_on  = [null_resource.build_lambda]
}
