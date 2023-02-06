#!/bin/bash
#export http_proxy=http://10.43.216.8:8080
#export https_proxy=http://10.43.216.8:8080
#FILE=/tmp/jammy-server-cloudimg-amd64-disk-kvm.img
FILE=/tmp/jammy-server-cloudimg-amd64.img
VMID=9001
if [[ -f "$FILE" ]]; then
	echo $FILE already downloaded
else
#	curl -sS -o /tmp/jammy-server-cloudimg-amd64-disk-kvm.img https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64-disk-kvm.img
	curl -sS -o /tmp/jammy-server-cloudimg-amd64.img https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img
	virt-customize --install qemu-guest-agent /tmp/jammy-server-cloudimg-amd64.img
fi
qm destroy $VMID
qm create $VMID -name ubuntu-2204-cloudinit-template -memory 2048 -net0 virtio,bridge=vmbr0 -cores 2 -sockets 1 -cpu cputype=kvm64 -description "Ubuntu 22.04 cloud image" -kvm 1 -numa 1
qm importdisk $VMID $FILE local-lvm
qm set $VMID -scsihw virtio-scsi-pci -virtio0 local-lvm:vm-9001-disk-0
qm set $VMID -serial0 socket
qm set $VMID -boot c -bootdisk virtio0
qm set $VMID -agent 1
qm set $VMID -hotplug disk,network,usb,memory,cpu
qm set $VMID -vcpus 1
qm set $VMID -vga qxl
qm set $VMID -name ubuntu-2204-cloudinit-template
qm set $VMID -ide2 local-lvm:cloudinit
qm set $VMID -sshkey /tmp/id_rsa_vms.pub
qm resize $VMID virtio0 8G
