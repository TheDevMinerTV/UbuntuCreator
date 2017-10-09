#!/bin/bash

sudo mkdir $1
SOURCE=$1

echo
echo
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !!!-----------Welcome to-----------!!!
echo !!!---------Ubuntu Creator---------!!!
echo !!!----Created by TheDevMinerTV----!!!
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo
echo


echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !!!--Where is your project folder?------------------!!!
read WORK
echo !!!--How is your new Ubuntu called?-----------------!!!
read NAME
echo !!!--Where is your base iso image?------------------!!!
read ISO
echo !!!--How big will the temporary filesystem be?------!!!
echo !!!--Give it in Mbytes--min size of iso image by 4--!!!
read SIZE
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo
echo


echo !
echo !--Mounting the ISO image . . .
echo !
echo
echo

mount -o loop $ISO $SOURCE


echo
echo !
echo !--Creating the WORK folder . . .
echo !
echo
echo

mkdir -p "${WORK}" 


echo
echo !
echo !--Copying the files from the iso image . . .
echo !
echo
echo

cd "${WORK}"
mkdir ubuntu-livecd
cp -a "${SOURCE}/." ubuntu-livecd
sudo chmod -R u+w ubuntu-livecd 


echo
echo !
echo !--Finding and deleting the windows files . . .
echo !
echo
echo

find "${WORK}/ubuntu-livecd" -name "*.exe" 


echo
echo !
echo !--Mounting the old SquashFS filesystem . . .
echo !
echo
echo

mkdir "${WORK}/old"
sudo mount -t squashfs -o loop,ro "${WORK}/ubuntu-livecd/casper/filesystem.squashfs" "${WORK}/old" 


echo
echo !
echo !--Creating new filesystem . . .
echo !
echo
echo

sudo dd if=/dev/zero of="${WORK}/ubuntu-fs.ext2" bs=1M count=$SIZE
sudo mke2fs "${WORK}/ubuntu-fs.ext2" 


echo
echo !
echo !--Copying and extracting the SquashFS filesystem and unmouting the old SquashFS filesystem . . .
echo !
echo
echo

mkdir "${WORK}/new"
sudo mount -o loop "${WORK}/ubuntu-fs.ext2" "${WORK}/new"
sudo cp -a "${WORK}/old/." "${WORK}/new" 
sudo umount "${WORK}/old" 


echo
echo !
echo !--Creating network configuration and mounting the "proc" and the "pts" filesystems . . .
echo !
echo
echo

sudo cp /etc/resolv.conf "${WORK}/new/etc/" 
sudo mount -t proc -o bind /proc "${WORK}/new/proc" 
sudo mount -o bind /dev/pts "${WORK}/new/dev/pts" 


echo
echo !
echo !--Chrooting . . .
echo !--Continue with "exit"
echo !
echo
echo

sudo chroot "${WORK}/new" /bin/bash 


echo
echo !
echo !--Removing the network configuration and unmounting the "proc" and the "pts" filesystems . . .
echo !
echo
echo

sudo umount "${WORK}/new/proc"
sudo umount "${WORK}/new/dev/pts"
sudo rm "${WORK}/new/etc/resolv.conf" 


echo
echo !
echo !--Generating new filesystem.manifest . . .
echo !
echo
echo

sudo chroot "${WORK}/new" dpkg-query -W --showformat='${Package} ${Version}\n' \
    > "${WORK}/ubuntu-livecd/casper/filesystem.manifest" 


echo
echo !
echo !--Overriding deleted files by creating a dummyfile and removing the dummyfile . . .
echo !
echo
echo

sudo dd if=/dev/zero of="${WORK}/new/dummyfile"
sudo rm "${WORK}/new/dummyfile" 


echo
echo !
echo !--Creating a new SquashFS image . . .
echo !
echo
echo

sudo rm "${WORK}/ubuntu-livecd/casper/filesystem.squashfs"
cd "${WORK}/new"
sudo mksquashfs . "${WORK}/ubuntu-livecd/casper/filesystem.squashfs"
cd "${WORK}"
sudo umount "${WORK}/new" 


echo
echo !
echo !--Calculating new MD5-sums . . .
echo !
echo
echo

cd "${WORK}/ubuntu-livecd"
sudo find . -type f -print0 |xargs -0 md5sum |sudo tee md5sum.txt 


echo
echo !
echo !--Generating new ISO Image . . .
echo !
echo
echo

cd "${WORK}"
sudo genisoimage \
    -o ${NAME}.iso \
    -b isolinux/isolinux.bin \
    -c isolinux/boot.cat \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -r \
    -V "${NAME}" \
    -cache-inodes  \
    -J \
    -l \
    ubuntu-livecd 


echo
echo !
echo !--Cleaning up . . .
echo !
echo
echo


