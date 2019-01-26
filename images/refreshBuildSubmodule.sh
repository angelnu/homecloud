#!/bin/sh
for i in $(ls);do echo $i;bash -c "cd $i/build&&git pull&&cd ..&&git commit -a -m 'Update build'&&git push">/dev/null;done
