packer {
  required_plugins {
    proxmox = {
      version = ">= 1.0.6"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}

variable "token" {
  type    = string
}

variable "user" {
  type    = string
}

variable "http_ip" {
  type    = string
}

variable "netmaker_token" {
  type    = string
}
# The "legacy_isotime" function has been provided for backwards compatability, but we recommend switching to the timestamp and formatdate functions.

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
source "proxmox" "oracle_linux_R8_U6_x86_64" {
  boot_command        = [
    "<tab>",
    " inst.text inst.sshd inst.ks=https://raw.githubusercontent.com/calebgasser/proxmox-packer/develop/http/Oracle-Linux-R8-U6-x86_64/ks.cfg TOKEN=${var.netmaker_token}",
    "<enter>",
    "<wait>"
  ]
  boot_wait           = "10s"
  memory              = "4096"
  cores               = 2
  scsi_controller     = "virtio-scsi-pci"
  disks {
    disk_size         = "32G"
    storage_pool      = "local-lvm"
    storage_pool_type = "lvm"
    type              = "virtio"
  }
  http_directory           = "http/Oracle-Linux-R8-U6-x86_64"
  insecure_skip_tls_verify = true
  iso_file                 = "proxmox-iso:iso/OracleLinux-R8-U6-x86_64-dvd.iso"
  network_adapters {
    bridge = "vmbr0"
  }
  node                 = "pve-1"
  token                = "${var.token}"
  proxmox_url          = "https://10.1.0.6:8006/api2/json"
  ssh_password         = "packer"
  ssh_timeout          = "30m"
  ssh_username         = "packer"
  template_description = "Oracle Linux R8 U6, generated on ${legacy_isotime("2006-01-02T15:04:05Z")}"
  template_name        = "oracle-linux"
  unmount_iso          = true
  username             = "${var.user}"
}

build {
  sources = ["source.proxmox.oracle_linux_R8_U6_x86_64"]

}
