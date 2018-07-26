#!/bin/bash

echo
echo !
echo !--Installing the depencies . . .
echo !
echo
echo

sudo apt-get install squashfs-tools genisoimage dialog -y

chmod u+x ./bin/ucreator

echo 
echo !
echo !--Extending PATH to `pwd`
echo !
echo 

echo "PATH=`pwd`/bin:\$PATH" >>  ~/.bashrc

echo Finished successfully . . .

exit 0
