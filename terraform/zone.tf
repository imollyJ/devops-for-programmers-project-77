resource "yandex_dns_zone" "zone-mollyj" {
  zone        = format("%s%s", var.domain, ".")
  name        = "mollyj"
  description = "mollyj public zone"
  public      = true
}

resource "yandex_dns_recordset" "mollyj-rs-a" {
  zone_id = yandex_dns_zone.zone-mollyj.id
  name    = format("%s%s", var.domain, ".")
  type    = "A"
  ttl     = 60
  data    = [yandex_alb_load_balancer.lb-mollyj.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
}
