#!/bin/bash
export http_proxy=$2
export https_proxy=$2
DIR=jammy/current
#FILE=jammy-server-cloudimg-amd64-disk-kvm.img
FILE=jammy-server-cloudimg-amd64.img
VMID=$1
NAME="Ubuntu 22.04 cloud image"
if [[ -f "/tmp/$FILE" ]]; then
	echo /tmp/$FILE already downloaded
else
	curl -sS -o /tmp/$FILE https://cloud-images.ubuntu.com/$DIR/$FILE
	apt install -y libguestfs-tools
	virt-customize --install qemu-guest-agent -a /tmp/$FILE
fi
qm destroy $VMID
qm create $VMID -name ubuntu-2204-cloudinit-template -memory 2048 -net0 virtio,bridge=vmbr0 -cores 2 -sockets 1 -cpu cputype=kvm64 -description "$NAME" -kvm 1 -numa 1
qm importdisk $VMID /tmp/$FILE local-lvm
qm set $VMID -scsihw virtio-scsi-pci -virtio0 local-lvm:vm-$VMID-disk-0
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
