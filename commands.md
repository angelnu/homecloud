
## Setup

### Dependencies
* [Ansible](https://www.ansible.com/)
* `git checkout --recursive https://github.com/angelnu/homecloud.git`

### Base HW + OS
1. Install any Debian/Ubuntu based OS. I use:
   - [Odroid /Orange PI] (https://www.armbian.com/download/)
   - [Raspberry](https://github.com/hypriot/image-builder-rpi/releases/)
2. Setup ssh access to root using an ssh key
3. Install python
3. (optional) Mount /media/data to a large enough folder. Most of the data will go here, including the glusterfs bricks
4. edit hosts
5. (optional) edit group_vars
6. Ensure that /etc/machine-id is unique in all nodes or run (see https://groups.google.com/forum/#!topic/beagleboard/aJLOyi_Pzz8):
   - `ansible-playbook -i hosts hw_reset.yaml`
7. `ansible-playbook -i hosts hw_setup.yaml`
8. `ansible-playbook -i hosts hw_update.yaml`

### Setup Kubernetes

1. `ansible-playbook -i hosts k8s_install.yaml`
   - Use `ansible-playbook -i hosts k8s_reset.yaml` if there is an old installation to reset

### (Optional) Build docker images

1. `ansible-playbook -i hosts images_build.yaml`

### Deploy services
Only needed if you modify the services after the cluster setup
- `ansible-playbook -i hosts k8s_update_services.yaml`
or
- `export KUBECONFIG=kubeconfig/admin.conf`
- `kubectl update -f services`

### Testing
- Deploy the pub key to the test workers
- Call `bin/test_all.sh` from the top git checkout folder.
