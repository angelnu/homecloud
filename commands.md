
## Setup

### Dependencies
* [Ansible](https://www.ansible.com/)
* `git checkout --recursive git@github.com:angelnu/homecloud.git`

### Base HW + OS
1. Install any Debian/Ubuntu based OS. I use:
   - [Odroid /Orange PI] (https://www.armbian.com/download/)
   - [Raspberry](https://github.com/hypriot/image-builder-rpi/releases/)
2. Setup ssh access to root using an ssh key
3. (optional) Mount /media/data to a large enough folder. Most of the data will go here, including the glusterfs bricks
4. edit hosts
5. (optional) edit group_vars
6. Ensure that /etc/machine-id is unique in all nodes or run (see https://groups.google.com/forum/#!topic/beagleboard/aJLOyi_Pzz8):
   - `ansible-playbook -i hosts reset_machine.yml`
7. `ansible-playbook -i hosts setup.yml`

### Setup Kubernetes

1. `ansible-playbook -i hosts set_kubernetes.yaml`
   - Use `ansible-playbook -i hosts reset_kubernetes.yaml` if there is an old installation to reset

### (Optional) Build docker images

1. `ansible-playbook -i hosts images.yml`

### Deploy services
Only needed if you modify the services after the cluster setup
- `ansible-playbook -i hosts set_kubernetes_services.yaml`
or
- `export KUBECONFIG=kubeconfig/admin.conf`
- `kubectl update -f services`
