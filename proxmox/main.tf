terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://pve1.gemalto.com:8006/api2/json"
#  pm_api_token_id = "root"
#  pm_api_token_secret = "krissfr"
  pm_user = "root@pam"
  pm_password = "krissfr"
  pm_debug = "true"
  pm_tls_insecure = true
  pm_log_enable = true
  pm_log_file = "terraform-plugin-proxmox.log"
  pm_log_levels = {
    _default = "debug"
    _capturelog = ""
  }
}

resource "proxmox_vm_qemu" "controller" {
  count = 1
  name = "controller"
  target_node = "pve1"

  clone = "ubuntu-2004-cloudinit-template"

  agent = 1
  os_type = "cloud-init"
  cores = 1
  sockets = 1
  cpu = "host"
  memory = 1024
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=10.10.10.2/24,gw=10.10.10.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}


resource "proxmox_vm_qemu" "kube-server" {
  count = 1
  name = "kube-server-0${count.index + 1}"
  target_node = "pve1"

  clone = "ubuntu-2004-cloudinit-template"

  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=10.10.10.1${count.index + 1}/24,gw=10.10.10.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "kube-agent" {
  count = 2
  name = "kube-agent-0${count.index + 1}"
  target_node = "pve1"

  clone = "ubuntu-2004-cloudinit-template"

  agent = 1
  os_type = "cloud-init"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 4096
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"

  disk {
    slot = 0
    size = "10G"
    type = "scsi"
    storage = "local-lvm"
    iothread = 1
  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }
  
  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = "ip=10.10.10.2${count.index + 1}/24,gw=10.10.10.1"
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

