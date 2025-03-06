variable "yc_iam_token" {
  description = "IAM-токен (время жизни не более 12 часов)"
  type        = string
  sensitive   = true
}

variable "yc_token" {
  description = "OAuth-токен"
  type        = string
  sensitive   = true
}

variable "yc_cloud_id" {
  description = "id облака"
  type        = string
  sensitive   = true
}

variable "yc_folder_id" {
  description = "id каталога"
  type        = string
  sensitive   = true
}

variable "db_name" {
  description = "Имя БД"
  type        = string
  sensitive   = true
}

variable "db_user" {
  description = "Пользователь"
  type        = string
  //  sensitive   = true
}

variable "db_password" {
  description = "Пароль"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "Домен"
  type        = string
}

variable "tls_cert_id" {
  description = "Идентификатор сертификата"
  type        = string
  sensitive   = true
}

#variable "datadog_api_key" {
#  description = "API-key datadog"
#  type        = string
#  sensitive   = true
#}

#variable "datadog_app_key" {
#  description = "APP-key datadog"
#  type        = string
#  sensitive   = true
#}
