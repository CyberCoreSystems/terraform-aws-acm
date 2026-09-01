output "certificate_arn" {
  description = "ARN of the issued/pending certificate."
  value       = module.certificate.certificate_arn
}

output "certificate_status" {
  description = "Certificate status (PENDING_VALIDATION until DNS records resolve)."
  value       = module.certificate.status
}

output "domain_validation_options" {
  description = "DNS records to publish to validate the certificate."
  value       = module.certificate.domain_validation_options
}
