output "alb_external_ip" {
  description = "External IP of the Application Load Balancer"
  value       = yandex_alb_load_balancer.lb-mollyj.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}
