#!/bin/sh
bin/test_hw_install.sh &&
bin/test_hw_update.sh &&
bin/test_k8s_install.sh &&
bin/test_k8s_update.sh &&
echo "$0 sucesfull"

exit $?
