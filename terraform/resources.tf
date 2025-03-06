resource "yandex_vpc_network" "net" {
  name = "net-mollyj"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet-mollyj"
  zone           = var.zone_id
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["192.168.192.0/24"]
}
