output "certificate_arn" {
  description = "ARN of the certificate. Pass this to an ALB listener, CloudFront distribution, or API Gateway custom domain."
  value       = aws_acm_certificate.this.arn
}

output "certificate_id" {
  description = "Certificate identifier (equal to the ARN for ACM)."
  value       = aws_acm_certificate.this.id
}

output "domain_name" {
  description = "Primary domain name (CN) of the certificate."
  value       = aws_acm_certificate.this.domain_name
}

output "status" {
  description = "Certificate status — PENDING_VALIDATION until the DNS validation records resolve, then ISSUED."
  value       = aws_acm_certificate.this.status
}

output "validation_method" {
  description = "Validation method in effect (DNS or EMAIL)."
  value       = aws_acm_certificate.this.validation_method
}

output "domain_validation_options" {
  description = "Records to publish to validate (and auto-renew) the certificate. For DNS validation each entry has resource_record_name/type/value — create one CNAME per entry (e.g. via aws_route53_record)."
  value       = aws_acm_certificate.this.domain_validation_options
}
