variable "region" {
  description = "AWS region to create the certificate in. For CloudFront the certificate must live in us-east-1."
  type        = string
  default     = "us-east-1"
}

variable "domain_name" {
  description = "Primary domain name for the certificate."
  type        = string
  default     = "example.com"
}

variable "subject_alternative_names" {
  description = "Additional names (SANs) to secure on the certificate."
  type        = list(string)
  default     = ["www.example.com"]
}
