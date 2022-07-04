# Packer files for building images on proxmox.

### Resources and References

#### [RHEL Cloud Init Reference](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html-single/configuring_and_managing_cloud-init_for_rhel_8/index#ftn.CO1-1)

#### [How to build a KVM image for vagrant using packer.](https://www.packer.io/plugins/builders/qemu)

#### [Proxmox packer plugin.](https://github.com/hashicorp/packer-plugin-proxmox/blob/main/docs/builders/iso.mdx)

#### [Oracle linux packer reference.](https://github.com/biemond/packer-oracle-linux)

#### Convert JSON to HCL2.

`packer hcl2_upgrade -with-annotations <packer-json-file>.json`
