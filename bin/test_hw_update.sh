#!/bin/sh
ansible-playbook -i hosts hw_update.yaml &&
echo "$0 sucesfull"

exit $?
