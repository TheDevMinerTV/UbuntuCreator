#!/bin/bash

echo
echo !
echo !--Installing the depencies . . .
echo !
echo
echo

sudo apt-get install squashfs-tools genisoimage -y

chmod u+x ./ubuntucreator.sh

sudo cp ./ubuntucreator.sh /bin/ 
sudo cp ./ubuntucreator.sh /sbin/ 

echo Finished successfully . . .

exit 0
