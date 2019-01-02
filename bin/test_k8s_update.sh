#!/bin/sh
ansible-playbook -i hosts k8s_update_services.yaml &&
echo "$0 sucesfull"

exit $?
