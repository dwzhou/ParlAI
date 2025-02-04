# Taken from this comment: https://github.com/alexhyett/alexhyett-comments/discussions/8#discussioncomment-1836457
# Chose DNS validation over email validation
resource "aws_acm_certificate" "ssl_certificate" {
    provider = aws.acm_provider
    domain_name = var.domain_name
    subject_alternative_names = ["*.${var.domain_name}"]
    validation_method = "DNS"
    tags = var.common_tags
    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_route53_record" "main" {
    for_each = {
        for dvo in aws_acm_certificate.ssl_certificate.domain_validation_options : dvo.domain_name => {
            name = dvo.resource_record_name
            record = dvo.resource_record_value
            type = dvo.resource_record_type
        }
    }
    allow_overwrite = true
    name = each.value.name
    records = [each.value.record]
    ttl = 60
    type = each.value.type
    zone_id = aws_route53_zone.main.zone_id
}

resource "aws_acm_certificate_validation" "cert_validation" {
    provider = aws.acm_provider
    certificate_arn = aws_acm_certificate.ssl_certificate.arn
    validation_record_fqdns = [for record in aws_route53_record.main : record.fqdn]
}
