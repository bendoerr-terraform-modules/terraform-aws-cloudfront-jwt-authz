variable "context" {
  type = object({
    attributes     = list(string)
    dns_namespace  = string
    environment    = string
    instance       = string
    instance_short = string
    namespace      = string
    region         = string
    region_short   = string
    role           = string
    role_short     = string
    project        = string
    tags           = map(string)
  })
  description = "Shared context from the 'bendoerr-terraform-modules/terraform-null-context' module."
}

variable "name" {
  type        = string
  default     = "thing"
  description = "A descriptive but short name used for labels by the 'bendoerr-terraform-modules/terraform-null-label' module."
  nullable    = false
}

variable "jwt_issuer" {
  type        = string
  description = "The issuer URI for JWT token validation in the Authorization lambda"
  nullable    = false
}

variable "jwt_audience" {
  type        = string
  description = "The audience value for JWT token validation in the Authorization lambda"
  nullable    = false
}

variable "jwt_jwks_url" {
  type        = string
  description = "The JWKS URL for retrieving public keys for JWT token validation in the Authorization lambda"
  nullable    = false
}

variable "cloudfront_distribution_arn" {
  description = "ARN of the CloudFront distribution that will use this Lambda@Edge function. Used to set appropriate permissions for Lambda function execution. If not provided, it will default to all distributions in the deployment account."
  type        = string
  default     = null
}
