source "virtualbox-iso" "ubuntu" {
  guest_os_type = "Ubuntu_64"
  iso_url = "http://cdimage.ubuntu.com/ubuntu/releases/bionic/release/ubuntu-18.04.5-server-amd64.iso"
  iso_checksum = "sha256:8c5fc24894394035402f66f3824beb7234b757dd2b5531379cb310cedfdf0996"
  ssh_username = "packer"
  ssh_password = "packer"
  ssh_port= 22
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  http_directory = "http"
  guest_additions_mode = "disable"
  boot_command = [
        "",
        "",
        "",
        "/install/vmlinuz",
        " auto",
        " console-setup/ask_detect=false",
        " console-setup/layoutcode=us",
        " console-setup/modelcode=pc105",
        " debconf/frontend=noninteractive",
        " debian-installer=en_US",
        " fb=false",
        " initrd=/install/initrd.gz",
        " kbd-chooser/method=us",
        " keyboard-configuration/layout=USA",
        " keyboard-configuration/variant=USA",
        " locale=en_US",
        " netcfg/get_domain=vm",
        " netcfg/get_hostname=packer",
        " grub-installer/bootdev=/dev/sda",
        " noapic",
        " preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg",
        " -- ",
        ""
      ]
}

