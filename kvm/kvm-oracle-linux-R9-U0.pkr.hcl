variable "config_file" {
  type    = string
  default = "ks.cfg"
}

variable "disk_size" {
  type    = string
  default = "32768"
}

variable "headless" {
  type    = bool
  default = false 
}

variable "iso_checksum" {
  type    = string
  default = "d5fe339e2f6c4bc157e294bd218eb49c1a920473cae552fb00cfc8978ead3d67"
}

variable "iso_checksum_type" {
  type    = string
  default = "sha256"
}

variable "iso_urls" {
  type    = list(string)
  default = ["https://yum.oracle.com/ISOS/OracleLinux/OL9/u0/x86_64/OracleLinux-R9-U0-x86_64-dvd.iso"]
}

variable "cpu" {
  type    = string
  default = "2"
}

variable "ram" {
  type    = string
  default = "2048"
}

variable "ssh_password" {
  type    = string
  default = "password"
}

variable "ssh_username" {
  type    = string
  default = "root"
}

variable "name" {
  type    = string
  default = "Oracle-Linux-R9-U0-x86_64"
}

# source blocks are generated from your builders; a source can be referenced in
# build blocks. A build block runs provisioner and post-processors on a
# source. Read the documentation for source blocks here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/source
# could not parse template for following block: "template: hcl2_upgrade:2: bad character U+0060 '`'"

source "qemu" "oracle_linux_r9_u0" {
  accelerator      = "kvm"
  http_directory   = "http/${var.name}"
  boot_command     = [
    "<tab>",
    " text inst.ks=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ks.cfg",
    "<enter>",
    "<wait>"
  ]
  boot_wait        = "10s"
  disk_cache       = "none"
  disk_compression = true
  disk_discard     = "unmap"
  disk_interface   = "virtio"
  disk_size        = var.disk_size
  format           = "qcow2"
  headless         = var.headless
  iso_checksum     = var.iso_checksum
  iso_urls         = var.iso_urls
  net_device       = "virtio-net"
  output_directory = "build/artifacts/qemu/${var.name}"
  qemuargs         = [["-m", "${var.ram}M"], ["-smp", "${var.cpu}"]]
  shutdown_command = "sudo /usr/sbin/shutdown -h now"
  ssh_password     = var.ssh_password
  ssh_username     = var.ssh_username
  ssh_wait_timeout = "30m"
}

# a build block invokes sources and runs provisioning steps on them. The
# documentation for build blocks can be found here:
# https://www.packer.io/docs/templates/hcl_templates/blocks/build
build {
  sources = ["source.qemu.oracle_linux_r9_u0"]
}
