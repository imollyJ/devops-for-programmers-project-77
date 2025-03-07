resource "local_file" "ansible_vars" {
  content  = templatefile("${path.module}/templates/vars.yml.tftpl", {
    domain = var.domain
  })
  filename = "${path.module}/../ansible/group_vars/all/vars.yml"
}

resource "local_file" "ansible_vault" {
  content  = templatefile("${path.module}/templates/vault.yml.tftpl", {
    db_host         = yandex_mdb_mysql_cluster.dbcluster.host[0].fqdn
    db_name         = var.db_name
    db_user         = var.db_user
    db_password     = var.db_password
    datadog_api_key = var.datadog_api_key
  })
  filename = "${path.module}/../ansible/group_vars/all/vault.yml"
}

resource "local_file" "ansible_inventory" {
  content  = templatefile("${path.module}/templates/inventory.ini.tftpl", {
    web_servers = yandex_compute_instance.web[*].network_interface[0].nat_ip_address
  })
  filename = "${path.module}/../ansible/inventory.ini"
}
