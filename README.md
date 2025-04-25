<br/>
<p align="center">
  <a href="https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz">
    <picture>
      <source media="(prefers-color-scheme: dark)" srcset="https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/raw/main/docs/logo-dark.png">
      <img src="https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/raw/main/docs/logo-light.png" alt="Logo">
    </picture>
  </a>

<h3 align="center">Ben's Terraform AWS Cloudfront JWT Authz</h3>

<p align="center">
    This is how I do it.
    <br/>
    <br/>
    <a href="https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz"><strong>Explore the docs »</strong></a>
    <br/>
    <br/>
    <a href="https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/issues">Report Bug</a>
    .
    <a href="https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/issues">Request Feature</a>
  </p>
</p>

[<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=github">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/graphs/contributors)
[<img alt="GitHub issues" src="https://img.shields.io/github/issues/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=github">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/issues)
[<img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=github">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/pulls)
[<img alt="GitHub workflow: Terratest" src="https://img.shields.io/github/actions/workflow/status/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/test.yml?logo=githubactions&label=terratest">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/actions/workflows/test.yml)
[<img alt="GitHub workflow: Linting" src="https://img.shields.io/github/actions/workflow/status/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/lint.yml?logo=githubactions&label=linting">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/actions/workflows/lint.yml)
[<img alt="GitHub tag (with filter)" src="https://img.shields.io/github/v/tag/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?filter=v*&label=latest%20tag&logo=terraform">](https://registry.terraform.io/modules/bendoerr-terraform-modules/cloudfront-with-s3-origin/aws/latest)
[<img alt="OSSF-Scorecard Score" src="https://img.shields.io/ossf-scorecard/github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=securityscorecard&label=ossf%20scorecard&link=https%3A%2F%2Fsecurityscorecards.dev%2Fviewer%2F%3Furi%3Dgithub.com%2Fbendoerr-terraform-modules%2Fterraform-aws-cloudfront-jwt-authz">](https://securityscorecards.dev/viewer/?uri=github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz)
[<img alt="GitHub License" src="https://img.shields.io/github/license/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=opensourceinitiative">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/blob/main/LICENSE.txt)

## About The Project

TODO

## Usage

TODO

<!-- BEGIN_TF_DOCS -->

### Requirements

| Name                                                                     | Version  |
| ------------------------------------------------------------------------ | -------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0.0 |
| <a name="requirement_archive"></a> [archive](#requirement_archive)       | 2.7.0    |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | ~> 5.0   |
| <a name="requirement_null"></a> [null](#requirement_null)                | 3.2.4    |

### Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_archive"></a> [archive](#provider_archive) | 2.7.0   |
| <a name="provider_aws"></a> [aws](#provider_aws)             | 5.95.0  |
| <a name="provider_null"></a> [null](#provider_null)          | 3.2.4   |

### Modules

| Name                                                  | Source                                                 | Version |
| ----------------------------------------------------- | ------------------------------------------------------ | ------- |
| <a name="module_label"></a> [label](#module_label)    | bendoerr-terraform-modules/label/null                  | 0.5.0   |
| <a name="module_lambda"></a> [lambda](#module_lambda) | /Users/bendoerr/Projects/personal/terraform-aws-lambda | n/a     |

### Resources

| Name                                                                                                                                    | Type        |
| --------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_lambda_permission.allow_cloudfront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource    |
| [null_resource.build_lambda](https://registry.terraform.io/providers/hashicorp/null/3.2.4/docs/resources/resource)                      | resource    |
| [archive_file.lambda_source](https://registry.terraform.io/providers/hashicorp/archive/2.7.0/docs/data-sources/file)                    | data source |

### Inputs

| Name                                                                  | Description                                                                                                   | Type                                                                                                                                                                                                                                                                                                                      | Default   | Required |
| --------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------- | :------: |
| <a name="input_context"></a> [context](#input_context)                | Shared context from the 'bendoerr-terraform-modules/terraform-null-context' module.                           | <pre>object({<br> attributes = list(string)<br> dns_namespace = string<br> environment = string<br> instance = string<br> instance_short = string<br> namespace = string<br> region = string<br> region_short = string<br> role = string<br> role_short = string<br> project = string<br> tags = map(string)<br> })</pre> | n/a       |   yes    |
| <a name="input_jwt_audience"></a> [jwt_audience](#input_jwt_audience) | The audience value for JWT token validation in the Authorization lambda                                       | `string`                                                                                                                                                                                                                                                                                                                  | n/a       |   yes    |
| <a name="input_jwt_issuer"></a> [jwt_issuer](#input_jwt_issuer)       | The issuer URI for JWT token validation in the Authorization lambda                                           | `string`                                                                                                                                                                                                                                                                                                                  | n/a       |   yes    |
| <a name="input_jwt_jwks_url"></a> [jwt_jwks_url](#input_jwt_jwks_url) | The JWKS URL for retrieving public keys for JWT token validation in the Authorization lambda                  | `string`                                                                                                                                                                                                                                                                                                                  | n/a       |   yes    |
| <a name="input_name"></a> [name](#input_name)                         | A descriptive but short name used for labels by the 'bendoerr-terraform-modules/terraform-null-label' module. | `string`                                                                                                                                                                                                                                                                                                                  | `"thing"` |    no    |

### Outputs

| Name                                                                                                                                | Description                                                                            |
| ----------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------- |
| <a name="output_id"></a> [id](#output_id)                                                                                           | The normalized ID from the 'bendoerr-terraform-modules/terraform-null-label' module.   |
| <a name="output_lambda_cloudwatch_log_group_arn"></a> [lambda_cloudwatch_log_group_arn](#output_lambda_cloudwatch_log_group_arn)    | The ARN of the CloudWatch Log Group for the Lambda function                            |
| <a name="output_lambda_cloudwatch_log_group_name"></a> [lambda_cloudwatch_log_group_name](#output_lambda_cloudwatch_log_group_name) | The name of the CloudWatch Log Group for the Lambda function                           |
| <a name="output_lambda_function_arn"></a> [lambda_function_arn](#output_lambda_function_arn)                                        | ARN of the deployed Lambda function                                                    |
| <a name="output_lambda_function_invoke_arn"></a> [lambda_function_invoke_arn](#output_lambda_function_invoke_arn)                   | The invoke ARN of the Lambda function                                                  |
| <a name="output_lambda_function_name"></a> [lambda_function_name](#output_lambda_function_name)                                     | Name of the deployed Lambda function                                                   |
| <a name="output_lambda_function_version"></a> [lambda_function_version](#output_lambda_function_version)                            | The published version of the Lambda function                                           |
| <a name="output_lambda_iam_role_arn"></a> [lambda_iam_role_arn](#output_lambda_iam_role_arn)                                        | ARN of the IAM role attached to the Lambda function                                    |
| <a name="output_lambda_layers_arns"></a> [lambda_layers_arns](#output_lambda_layers_arns)                                           | The ARNs of the Lambda layers attached to the function                                 |
| <a name="output_name"></a> [name](#output_name)                                                                                     | The provided name given to the module.                                                 |
| <a name="output_tags"></a> [tags](#output_tags)                                                                                     | The normalized tags from the 'bendoerr-terraform-modules/terraform-null-label' module. |

<!-- END_TF_DOCS -->

## Roadmap

[<img alt="GitHub issues" src="https://img.shields.io/github/issues/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=github">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/issues)

See the
[open issues](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/issues)
for a list of proposed features (and known issues).

## Contributing

[<img alt="GitHub pull requests" src="https://img.shields.io/github/issues-pr/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=github">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/pulls)

Contributions are what make the open source community such an amazing place to
learn, inspire, and create. Any contributions you make are **greatly
appreciated**.

- If you have suggestions for adding or removing projects, feel free to
  [open an issue](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/issues/new)
  to discuss it, or directly create a pull request after you edit the
  _README.md_ file with necessary changes.
- Please make sure you check your spelling and grammar.
- Create individual PR for each suggestion.

### Creating A Pull Request

1. Fork the Project
1. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
1. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
1. Push to the Branch (`git push origin feature/AmazingFeature`)
1. Open a Pull Request

## License

[<img alt="GitHub License" src="https://img.shields.io/github/license/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=opensourceinitiative">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/blob/main/LICENSE.txt)

Distributed under the MIT License. See
[LICENSE](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/blob/main/LICENSE.txt)
for more information.

## Authors

[<img alt="GitHub contributors" src="https://img.shields.io/github/contributors/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz?logo=github">](https://github.com/bendoerr-terraform-modules/terraform-aws-cloudfront-jwt-authz/graphs/contributors)

- **Benjamin R. Doerr** - _Terraformer_ -
  [Benjamin R. Doerr](https://github.com/bendoerr/) - _Built Ben's Terraform
  Modules_

## Supported Versions

Only the latest tagged version is supported.

## Reporting a Vulnerability

See [SECURITY.md](SECURITY.md).

## Acknowledgements

- [ShaanCoding (ReadME Generator)](https://github.com/ShaanCoding/ReadME-Generator)
- [OpenSSF - Helping me follow best practices](https://openssf.org/)
- [StepSecurity - Helping me follow best practices](https://app.stepsecurity.io/)
- [Infracost - Better than AWS Calculator](https://www.infracost.io/)
