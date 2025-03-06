terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.108.0"
    }
#    datadog = {
#      source = "DataDog/datadog"
#      version = " 3.57.0 "
#    }
  }
}

provider "yandex" {
  token     = var.yc_token
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = var.zone_id
}

#provider "datadog" {
#  api_key = var.datadog_api_key
#  app_key = var.datadog_app_key
#  api_url = "https://api.datadoghq.com/"
#}
