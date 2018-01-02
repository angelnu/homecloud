## Home Cloud deplyoment based on Kubernetes, iobroker and ansible

Creates/Updates my private cloud based on Kubernetes and deploy my services on it.

* Support HA Kubernetes cluster on ARM (Hybrid with Intel will be added)
* Use Glusterfs for persistent volumes (see gluster service)
* Deploy [Iobroker](https://github.com/ioBroker/ioBroker) for home automation

## HW List

Here is the hardware you will need to complete the project:

| Amount | Part | Price |
| ------ | ---- | ----- |
| 3 | [Odroid HC1 - Home Cloud 1](http://www.hardkernel.com/main/products/prdt_info.php?g_code=G150229074080) | [3 * 59,95 EUR](https://www.pollin.de/p/odroid-hc1-einplatinen-computer-fuer-nas-und-cluster-anwendungen-810766) |
| 3 | [Micro SD Card 32 GB](http://amzn.eu/5IMqzRx) | 5 * 11 EUR |
| 3 | [ODROID BACKUP BATTERY](https://www.pollin.de/p/odroid-backup-battery-810319) | 3x 3,95 EUR |
| 3 | [ODROID Power Supply](https://www.pollin.de/p/steckernetzteil-xing-yuan-xy-0504000-e-5-v-4-a-351773) | 3x 9,95 EUR |



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
1. `export KUBECONFIG=kubeconfig/admin.conf`
2.  `ansible-playbook -i hosts images.yml`

### Deploy services
1. `export KUBECONFIG=kubeconfig/admin.conf`
2. `kubectl update -f services`



## References

Inspired by [Sergio Sisternes](https://github.com/sesispla/kubernetes-raspberry-pi)'s project.
