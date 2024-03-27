# Taken from https://www.alexhyett.com/terraform-s3-static-website-hosting/#variablestf
# Minimal changes here (just renaming common_tags -> tags)

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "tags" {
  description = "Common tags applied to all components."
}
