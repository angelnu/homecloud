#!/bin/sh
ansible-playbook -i hosts hw_reset.yaml &&
ansible-playbook -i hosts hw_setup.yaml &&
echo "$0 sucesfull"

exit $?
