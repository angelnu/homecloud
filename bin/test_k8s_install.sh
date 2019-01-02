#!/bin/sh
ansible-playbook -i hosts k8s_reset.yaml &&
ansible-playbook -i hosts k8s_install.yaml &&
echo "$0 sucesfull"

exit $?
