terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

resource "proxmox_vm_qemu" "controller" {
  target_node = var.pve_node

  count = var.controller ? 1 : 0
  name = "controller"
  tags = "controller"

  clone = "ubuntu-2204-cloudinit-template"
  os_type = "cloud-init"
  agent = 1

  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
#  bootdisk = "scsi0"

#  disk {
#    slot = 0
#    size = "10G"
#    type = "scsi"
#    storage = "local-lvm"
#    iothread = 1
#  }

  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  ipconfig0 = format("ip=%s%d%s,gw=%s", element(regex("(\\d+\\.\\d+\\.\\d+\\.)\\d+/\\d+", var.controller_ip),0), parseint(element(regex("\\d+\\.\\d+\\.\\d+\\.(\\d+)/\\d+", var.controller_ip),0),10)+count.index, element(regex("\\d+\\.\\d+\\.\\d+\\.\\d+(/\\d+)", var.controller_ip),0), format("%s1", element(regex("(\\d+\\.\\d+\\.\\d+\\.)\\d+/\\d+", var.controller_ip),0)))
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "kube-master" {
  target_node = var.pve_node 

  count = var.master_count
  name = format("kube-master-%d", count.index + var.master_index)
  tags = "master"

  clone = "ubuntu-2204-cloudinit-template"
  os_type = "cloud-init"
  agent = 1

  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
#  bootdisk = "scsi0"

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

  ipconfig0 = format("ip=%s%d%s,gw=%s", element(regex("(\\d+\\.\\d+\\.\\d+\\.)\\d+/\\d+", var.master_ip),0), parseint(element(regex("\\d+\\.\\d+\\.\\d+\\.(\\d+)/\\d+", var.master_ip),0),10)+count.index, element(regex("\\d+\\.\\d+\\.\\d+\\.\\d+(/\\d+)", var.master_ip),0), format("%s1", element(regex("(\\d+\\.\\d+\\.\\d+\\.)\\d+/\\d+", var.master_ip),0)))
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

resource "proxmox_vm_qemu" "kube-worker" {
  target_node = var.pve_node

  count = var.worker_count
  name = format("kube-worker-%d", count.index + var.worker_index)
  tags = "worker"

  clone = "ubuntu-2204-cloudinit-template"
  os_type = "cloud-init"
  agent = 1
  
  cores = 4
  sockets = 1
  cpu = "host"
  memory = 8192
  scsihw = "virtio-scsi-pci"
#  bootdisk = "scsi0"

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

  ipconfig0 = format("ip=%s%d%s,gw=%s", element(regex("(\\d+\\.\\d+\\.\\d+\\.)\\d+/\\d+", var.worker_ip),0), parseint(element(regex("\\d+\\.\\d+\\.\\d+\\.(\\d+)/\\d+", var.worker_ip),0),10)+count.index, element(regex("\\d+\\.\\d+\\.\\d+\\.\\d+(/\\d+)", var.worker_ip),0), format("%s1", element(regex("(\\d+\\.\\d+\\.\\d+\\.)\\d+/\\d+", var.worker_ip),0))) 
  sshkeys = <<EOF
  ${var.ssh_key}
  EOF
}

