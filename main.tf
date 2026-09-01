# Public ACM TLS certificate, DNS-validated by default. This module requests
# the certificate and exposes the DNS records you must publish to validate and
# auto-renew it (domain_validation_options output).
#
# Deliberately NO aws_acm_certificate_validation resource: that resource blocks
# the apply until the validation records resolve, which couples a fast,
# free certificate request to slow, external DNS propagation. Publish the
# records from domain_validation_options (e.g. with aws_route53_record) and let
# ACM validate asynchronously; the certificate auto-renews thereafter.

resource "aws_acm_certificate" "this" {
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = var.validation_method
  key_algorithm             = var.key_algorithm

  options {
    # Certificate Transparency logging on by default — required for the
    # certificate to be trusted by modern browsers.
    certificate_transparency_logging_preference = var.certificate_transparency_logging_preference
  }

  # Renewals/SAN changes issue a new certificate; create the replacement before
  # destroying the old one so consumers (ALB/CloudFront/API GW) never reference
  # a deleted ARN mid-apply.
  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}
