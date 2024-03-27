module "website" {
  source = "./modules/website-hosting"

  domain_name = "parl.ai"
  bucket_name = "parl.ai"
  tags = {
    "website" = "parl.ai"
  }
}
