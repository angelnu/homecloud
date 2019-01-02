#!/bin/sh
ansible-playbook -i hosts reset_kubernetes.yaml &&
ansible-playbook -i hosts set_kubernetes.yaml &&
echo "$0 sucesfull"

exit $?
