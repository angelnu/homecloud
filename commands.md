
## Setup

### Dependencies
* [Ansible](https://www.ansible.com/)
* `git checkout --recursive git@github.com:angelnu/homecloud.git`

### Base HW + OS
1. Install any Debian/Ubuntu based OS. I use:
   - [Odroid /Orange PI] (https://www.armbian.com/download/)
   - [Raspberry](https://github.com/hypriot/image-builder-rpi/releases/)
2. Setup ssh access to root using an ssh key
3. Ensure that /etc/machine-id is unique in all nodes or run (see https://groups.google.com/forum/#!topic/beagleboard/aJLOyi_Pzz8):
   - `sudo rm -f /var/lib/dbus/machine-id`
   - `sudo rm -f /etc/machine-id`
   - `sudo dbus-uuidgen --ensure`
   - `sudo systemd-machine-id-setup`
4. (optional) Mount /media/data to a large enough folder. Most of the data will go here, including the glusterfs bricks
5. edit hosts
6. (optional) edit group_vars
7. `ansible-playbook -i hosts setup.yml`

### Setup Kubernetes

1. `ansible-playbook -i hosts master.yml`
   - Use `ansible-playbook -i hosts reset.yml` if there is an old installation to reset

### (Optional) Build docker images

1. `ansible-playbook -i hosts images.yml`

### Deploy services
`export KUBECONFIG=kubeconfig/admin.conf`
`kubectl update -f services`
