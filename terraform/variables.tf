variable "pve1_host" {
  type = string
  default = ""
}

variable "pve1_node" {
  type = string
  default = "pve"
}

variable "pve1_password" {
  type = string
  default = ""
}

variable "pve2_host" {
  type = string
  default = ""
}

variable "pve2_node" {
  type = string
  default = "pve"
}

variable "pve2_password" {
  type = string
  default = ""
}

variable "controller_ip" {
  type = string
  default = "10.10.10.2/24"
}

variable "master_ip" {
  type = string
  default = "10.10.10.11/24"
}

variable "worker_ip" {
  type = string
  default = "10.10.10.21/24"
}

variable "ssh_key" {
  type = string
  default = ""
}
