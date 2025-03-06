resource "yandex_alb_load_balancer" "lb-mollyj" {
  name       = "load-balancer-mollyj"
  network_id = yandex_vpc_network.net.id

  allocation_policy {
    location {
      zone_id   = var.zone_id
      subnet_id = yandex_vpc_subnet.subnet.id
    }
  }

  listener {
    name = "listener-web-servers-http"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      redirects {
        http_to_https = true
      }
    }
  }

  listener {
    name = "listener-web-servers-https"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [443]
    }
    tls {
      default_handler {
        http_handler {
          http_router_id = yandex_alb_http_router.mollyj-router.id
        }
        certificate_ids = [yandex_cm_certificate.mollyj-certificate.id]
      }
    }
  }
}

resource "yandex_alb_http_router" "mollyj-router" {
  name = "mollyj-http-router"
}

resource "yandex_alb_virtual_host" "mollyj-virtual-host" {
  name           = "mollyj-virtual-host"
  http_router_id = yandex_alb_http_router.mollyj-router.id

  route {
    name = "mollyj-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.mollyj-backend-group.id
        timeout          = "30s"
      }
    }
  }
}

resource "yandex_alb_backend_group" "mollyj-backend-group" {
  name = "mollyj-backend-group"

  http_backend {
    name             = "mollyj-http-backend"
    port             = 80
    target_group_ids = ["${yandex_alb_target_group.mollyj-web-servers.id}"]
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "10s"
      interval = "10s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_target_group" "mollyj-web-servers" {
  name = "target-group-mollyj"

  target {
    subnet_id  = yandex_vpc_subnet.subnet.id
    ip_address = yandex_compute_instance.vm1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.subnet.id
    ip_address = yandex_compute_instance.vm2.network_interface.0.ip_address
  }
}
