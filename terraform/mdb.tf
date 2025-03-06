resource "yandex_mdb_mysql_cluster" "dbcluster" {
  name        = "dbcluster-mollyj"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.net.id
  version     = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 16
  }

  mysql_config = {
    sql_mode                      = "ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION"
    max_connections               = 100
    default_authentication_plugin = "MYSQL_NATIVE_PASSWORD"
    innodb_print_all_deadlocks    = true
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.subnet.id
  }

  depends_on = [yandex_vpc_network.net, yandex_vpc_subnet.subnet]
}

resource "yandex_mdb_mysql_user" "dbuser" {
  cluster_id = yandex_mdb_mysql_cluster.dbcluster.id
  name       = var.db_user
  password   = var.db_password

  permission {
    database_name = yandex_mdb_mysql_database.db.name
    roles         = ["ALL"]
  }

  depends_on = [yandex_mdb_mysql_cluster.dbcluster]
}

resource "yandex_mdb_mysql_database" "db" {
  cluster_id = yandex_mdb_mysql_cluster.dbcluster.id
  name       = var.db_name

  depends_on = [yandex_mdb_mysql_cluster.dbcluster]
  lifecycle {
   ignore_changes = [name]
  }
}
