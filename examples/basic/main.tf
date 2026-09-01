provider "aws" {
  region = var.region
}

module "certificate" {
  source = "../../"

  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names

  # DNS validation (the default) lets ACM auto-renew the certificate forever
  # once the validation records below are published.
  validation_method = "DNS"

  tags = {
    Environment = "example"
    ManagedBy   = "iac-bazaar"
  }
}
