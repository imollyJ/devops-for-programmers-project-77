resource "yandex_cm_certificate" "mollyj-certificate" {
  name    = "mollyj-cert"
  domains = [var.domain]

  managed {
    challenge_type = "DNS_CNAME"
  }
}

resource "yandex_dns_recordset" "mollyj-validation-record" {
  zone_id = yandex_dns_zone.zone-mollyj.id
  name    = yandex_cm_certificate.mollyj-certificate.challenges[0].dns_name
  type    = yandex_cm_certificate.mollyj-certificate.challenges[0].dns_type
  data    = [yandex_cm_certificate.mollyj-certificate.challenges[0].dns_value]
  ttl     = 60
}

data "yandex_cm_certificate" "mollyj-data" {
  depends_on      = [yandex_dns_recordset.mollyj-validation-record]
  certificate_id  = yandex_cm_certificate.mollyj-certificate.id
  wait_validation = true
}
