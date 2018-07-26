#!/bin/bash

echo
echo !
echo !--Installing the depencies . . .
echo !
echo
echo

sudo apt-get install squashfs-tools genisoimage -y

chmod u+x ./ubuntucreator.sh

if [ -n "$1" ]
  then
  INSTDIR = $1
  else
  echo Defaulting to /usr/bin
  INSTDIR = /usr/bin
fi

sudo cp ./ubuntucreator.sh $INSTDIR

echo Finished successfully . . .

exit 0
