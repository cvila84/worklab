terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  alias = "pve1"
  pm_api_url = "${var.pve1_host}/api2/json"
#  pm_api_token_id = "root"
#  pm_api_token_secret = ""
  pm_user = "root@pam"
  pm_password = var.pve1_password
  pm_parallel = 1
  pm_debug = "false"
  pm_tls_insecure = true
  pm_log_enable = false
#  pm_log_file = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default = "debug"
    _capturelog = ""
  }
}

provider "proxmox" {
  alias = "pve2"
  pm_api_url = "${var.pve2_host}/api2/json"
#  pm_api_token_id = "root"
#  pm_api_token_secret = ""
  pm_user = "root@pam"
  pm_password = var.pve2_password
  pm_parallel = 1
  pm_debug = "false"
  pm_tls_insecure = true
  pm_log_enable = false
#  pm_log_file = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default = "debug"
    _capturelog = ""
  }
}

module "kubernetes_pve1" {
  source = "./modules/kubernetes"
  providers = {
    proxmox = proxmox.pve1
  }
  pve_node = "pve1"
  controller = true
  master_count = 2
  master_index = 1
  worker_count = 2
  worker_index = 1
  controller_ip = "192.168.1.11/24"
  master_ip = "192.168.1.21/24"
  worker_ip = "192.168.1.31/24"
  controller_gw = "2"
  master_gw = "2"
  worker_gw = "2"
}

module "kubernetes_pve2" {
  source = "./modules/kubernetes"
  providers = {
    proxmox = proxmox.pve1
  }
  pve_node = "pve2"
  controller = false
  master_count = 1
  master_index = 3
  worker_count = 3
  worker_index = 3
  controller_ip = "192.168.1.12/24"
  master_ip = "192.168.1.23/24"
  worker_ip = "192.168.1.33/24"
  controller_gw = "3"
  master_gw = "3"
  worker_gw = "3"
}
