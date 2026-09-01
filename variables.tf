variable "domain_name" {
  description = "Fully-qualified domain name for the certificate (the CN). A leading \"*.\" requests a wildcard certificate, e.g. \"*.example.com\"."
  type        = string

  validation {
    condition     = can(regex("^(\\*\\.)?([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,63}$", var.domain_name)) && length(var.domain_name) <= 253
    error_message = "domain_name must be a valid DNS name (an optional leading \"*.\" wildcard is allowed) of at most 253 characters."
  }
}

variable "subject_alternative_names" {
  description = "Additional FQDNs to secure on the same certificate (SANs). Each may be a wildcard. Do not repeat domain_name here."
  type        = list(string)
  default     = []

  validation {
    condition = alltrue([
      for san in var.subject_alternative_names :
      can(regex("^(\\*\\.)?([a-zA-Z0-9]([a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,63}$", san)) && length(san) <= 253
    ])
    error_message = "every subject_alternative_names entry must be a valid DNS name (an optional leading \"*.\" wildcard is allowed) of at most 253 characters."
  }
}

variable "validation_method" {
  description = "How AWS proves you control the domain. DNS (recommended) lets the certificate auto-renew forever via a CNAME you publish once; EMAIL requires manual approval per renewal."
  type        = string
  default     = "DNS"

  validation {
    condition     = contains(["DNS", "EMAIL"], var.validation_method)
    error_message = "validation_method must be DNS or EMAIL."
  }
}

variable "key_algorithm" {
  description = "Key algorithm for the certificate. RSA_2048 has the broadest client compatibility; the EC algorithms are smaller/faster and still widely supported."
  type        = string
  default     = "RSA_2048"

  validation {
    condition     = contains(["RSA_2048", "EC_prime256v1", "EC_secp384r1"], var.key_algorithm)
    error_message = "key_algorithm must be one of RSA_2048, EC_prime256v1, EC_secp384r1 (the algorithms ACM can issue for public certificates)."
  }
}

variable "certificate_transparency_logging_preference" {
  description = "Certificate Transparency (CT) logging. ENABLED (the default, and an industry requirement for browser trust) publishes issuance to public CT logs; only DISABLE for private/internal names you must keep out of public logs."
  type        = string
  default     = "ENABLED"

  validation {
    condition     = contains(["ENABLED", "DISABLED"], var.certificate_transparency_logging_preference)
    error_message = "certificate_transparency_logging_preference must be ENABLED or DISABLED."
  }
}

variable "tags" {
  description = "Tags applied to the certificate."
  type        = map(string)
  default     = {}
}
