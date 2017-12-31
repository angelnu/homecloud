
First Setup
===========
1. edit config.yml (copied from config.example.yml)
2. edit hosts (copied from hosts.example)
3. `ansible-playbook -i hosts setup.yml`



Setup master
============
0. Ensure that /etc/machine-id is unique in all nodes or run (see https://groups.google.com/forum/#!topic/beagleboard/aJLOyi_Pzz8):
   - `sudo rm -f /var/lib/dbus/machine-id`
   - `sudo rm -f /etc/machine-id`
   - `sudo dbus-uuidgen --ensure`
   - `sudo systemd-machine-id-setup`
1. `ansible-playbook -i hosts master.yml`
   - Use `ansible-playbook -i hosts reset.yml` if there is an old installation to reset

Deploy casa
===========
`export KUBECONFIG=kubeconfig/admin.conf`
`kubectl update -f services`
