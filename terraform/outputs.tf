output "alb_external_ip" {
  description = "External IP of the Application Load Balancer"
  value       = yandex_alb_load_balancer.lb-mollyj.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

output "db_host" {
  value = yandex_mdb_mysql_cluster.dbcluster.host[0].fqdn
}

output "web_servers" {
  value = [
    yandex_compute_instance.vm1.network_interface[0].nat_ip_address,
    yandex_compute_instance.vm2.network_interface[0].nat_ip_address
  ]
}
