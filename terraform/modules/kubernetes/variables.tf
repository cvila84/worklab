variable "pve_node" {
  type = string
  default = "pve"
}

variable "controller" {
  type = bool
  default = false
}

variable "master_count" {
  type = number
  default = 1
}

variable "master_index" {
  type = number
  default = 1
}

variable "worker_count" {
  type = number
  default = 1
}

variable "worker_index" {
  type = number
  default = 1
}

variable "controller_ip" {
  type = string
  default = "10.0.0.2/24"
}

variable "master_ip" {
  type = string
  default = "10.0.0.11/24"
}

variable "worker_ip" {
  type = string
  default = "10.0.0.21/24"
}

variable "ssh_key" {
  type = string
  default = ""
}
