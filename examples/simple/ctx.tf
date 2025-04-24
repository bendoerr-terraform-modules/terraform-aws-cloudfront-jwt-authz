module "context" {
  source    = "bendoerr-terraform-modules/context/null"
  version   = "0.5.1"
  namespace = var.namespace
  role      = "cloudfront-jwt-authz"
  region    = "us-east-1"
  project   = "example"
  long_dns  = true
}
