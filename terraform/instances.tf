resource "yandex_compute_instance" "vm1" {
  name = "mollyj-1"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.img.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    user-data = "${file("cloud-init.yaml")}"
  }

  depends_on = [yandex_mdb_mysql_cluster.dbcluster]
}

resource "yandex_compute_instance" "vm2" {
  name = "mollyj-2"
  zone = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.img.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    user-data = "${file("cloud-init.yaml")}"
  }

  depends_on = [yandex_mdb_mysql_cluster.dbcluster]
}
