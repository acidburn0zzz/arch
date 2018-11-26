#!/bin/bash

loadkeys de
timedatectl set-ntp 1

# Partition
# TODO reset & wipe SSD
gdisk /dev/nvme0n1  # TODO optimize
# boot +256M ef00
# root

# Encrypt
mkdir key
mount -L USB key
cryptsetup luksFormat /dev/nvme0n1p2 -d key/.log
cryptsetup open /dev/nvme0n1p2 root -d key/.log

# Filesystems
mkfs.fat -F32 -n EFI /dev/nvme0n1p1
mkfs.ext4 -L ROOT /dev/mapper/root

# Mount
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L EFI /mnt/boot

# Install
nano /etc/pacman.d/mirrorlist
# Move server of choice to the top
pacstrap /mnt base base-devel bash-completion intel-ucode
genfstab -L /mnt >> /mnt/etc/fstab  # TODO optimize
arch-chroot /mnt

# Time
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock -w

# Host
echo hostname > /etc/hostname
nano /etc/hosts
# 127.0.0.1     localhost
# ::1           localhost
# 127.0.1.1     hostname.localdomain    hostname

# Language
echo KEYMAP=de-latin1 > /etc/vconsole.conf
echo LANG=en_US.UTF-8 > /etc/locale.conf
nano /etc/locale.gen
# Uncomment: en_US.UTF-8 UTF-8
locale-gen

# Bootloader
bootctl install
nano /boot/loader/loader.conf
# default   arch
# timeout   0
# editor    0
nano /boot/loader/entries/arch.conf
# title     Arch Linux Edge
# linux     /vmlinuz-linux
# initrd    /intel-ucode.img
# initrd    /initramfs-linux.img
# options   cryptdevice=/dev/nvme0n1p2:root
# options   cryptkey=LABEL=USB:vfat:.log
# options   root=LABEL=ROOT rw
# options   loglevel=3
# TODO timeout

# Initramfs
nano /etc/mkinitcpio.conf
# MODULES=(vfat)
# HOOKS=(base udev autodetect modconf block keyboard encrypt filesystems fsck)
mkinitcpio -p linux

# User
EDITOR=nano visudo
useradd -mG wheel aleks
passwd aleks
passwd
passwd -l root

# Exit
exit
umount -R /mnt
reboot
