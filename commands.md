
First Setup
===========
1. edit config.yml (copied from config.example.yml)
2. edit hosts (copied from hosts.example)
3. `ansible-playbook -i hosts setup.yml`



Setup master
============
1. `ansible-playbook -i hosts setup.yml`
   - Use `ansible-playbook -i hosts reset.yml` if there is an old installation to reset
