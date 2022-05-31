# Ansible role to install Home Assistant OS in Proxmox

Creates a VM in a Proxmox server and configures the latest release of [Home Assistant Operating System](https://github.com/home-assistant/operating-system) as its boot disk.

This role was heavily inspired by [this bash script](https://github.com/whiskerz007/proxmox_hassos_install). Thank you [whiskerz007](https://github.com/whiskerz007).

## Requirements

None.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

```yaml
haos_proxmox_api_password: PLEASE_REDEFINE_ME
haos_proxmox_api_user: admin@pam
```

These are used for authentication. `haos_proxmox_api_password` is required and must always be redefined.

```yaml
haos_proxmox_node: node
```

The name of the node in which the VM will be installed.

```yaml
haos_proxmox_storage: local-zfs
```

The storage location where the VM disks (EFI and HAOS image) will be created. Currently only two storage types are supported: ZFS and directory.

```yaml
haos_proxmox_cores: 1
haos_proxmox_description: 'Home Assistant'
haos_proxmox_mac_address: '' # If left empty a new one will be generated
haos_proxmox_memory: 4096
haos_proxmox_name: homeassistant
haos_proxmox_onboot: yes
haos_proxmox_protection: yes
haos_proxmox_sockets: 1
haos_proxmox_storage: local
haos_proxmox_storage_interface: sata0
```

Several VM attributes.

## Dependencies

None.

## Ansible Galaxy Installation

```bash
ansible-galaxy install nununo.proxmox_haos_install
```

## Example Playbook

```yaml
- hosts: myproxmox.mydomain.com
  roles:
  - role: nununo.proxmox_haos_install
```

Example of inventory entry:

```yaml
myhomeassistant.mydomain.com ansible_host=10.0.0.10 # (Proxmox's IP)
```

Example of host variables in `/host_vars/myhomeassistant.mydomain.com/vars.yml`:

```yaml
haos_proxmox_api_password: ENCRYPTED_PROXMOX_API_PASSWORD
haos_proxmox_api_user: root@pam
haos_proxmox_description: "MyHomeAssistant"
haos_proxmox_mac_address: 'AB:CD:EF:12:34:56'
haos_proxmox_name: myhomeassistsant
haos_proxmox_node: myproxmoxnode
haos_proxmox_storage: local-zfs
```

This role needs `sudo` capabilities.

## License

MIT / BSD

## Author Information

This role was created in 2022 by Nuno Godinho.
