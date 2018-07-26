#!/bin/bash

echo
echo !
echo !--Installing the depencies . . .
echo !
echo
echo

sudo apt-get install squashfs-tools genisoimage -y

chmod u+x ./ubuntucreator.sh

echo 
echo !
echo !--Installing to /usr/bin/ucreator
echo !
echo 

sudo cp ./ubuntucreator.sh /usr/bin/ucreator

echo Finished successfully . . .

exit 0
