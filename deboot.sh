#!/bin/bash


DIR=$(dirname "$0")
#ROOT=/mnt/ntfs/linux
ROOT=/mnt/img0

mkdir -p ${ROOT}/etc

debootstrap --arch amd64 --components main,restricted,universe,multiverse --include console-setup,aptitude,tasksel,gdm3,makedev,tzdata,locales,keyboard-configuration,git bionic ${ROOT}

mount --bind /proc ${ROOT}/proc
mount --bind /sys ${ROOT}/sys

echo MAKING /DEV ... PLEASE WAIT
chroot ${ROOT} bash -c "cd /dev && MAKEDEV generic"

mount --bind /dev/pts ${ROOT}/dev/pts

cp /etc/apt/sources.list ${ROOT}/etc/apt/sources.list

chroot ${ROOT} apt-get update

chroot ${ROOT} dpkg-reconfigure tzdata

chroot ${ROOT} dpkg-reconfigure keyboard-configuration

chroot ${ROOT} dpkg-reconfigure locales

chroot ${ROOT} tasksel install ubuntu-desktop
chroot ${ROOT} tasksel install standard
chroot ${ROOT} tasksel install server

chroot ${ROOT} apt-get install linux-image-4.18.0-16-generic -y 

chroot ${ROOT} adduser russosv

echo ENTER ROOT PASSWORD
chroot ${ROOT} passwd

#cp ${DIR}/mount-rootfs ${ROOT}/etc/initramfs-tools/scripts/init-premount/

chroot ${ROOT} mkinitramfs -o /boot/initrd.img-4.18.0-16-generic
. ${DIR}/linux-surface.sh

