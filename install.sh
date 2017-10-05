#!/bin/bash

echo
echo !
echo !--Installing the depencies . . .
echo !
echo
echo

sudo apt-get install squashfs-tools genisoimage -y



sudo cp ./ubuntucreator.sh /usr/bin/


echo Finished successfully . . .

exit 0
