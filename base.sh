#!/usr/bin/env sh

timedatectl set-ntp 1

# Partitions
gdisk /dev/nvme0n1
# boot +550M EF00, root

# Encryption
mkdir usb
mount -L USB usb
cryptsetup luksFormat /dev/nvme0n1p2 -d usb/key
cryptsetup open /dev/nvme0n1p2 root -d usb/key

# Filesystems
mkfs.vfat -F16 -n BOOT /dev/nvme0n1p1
mkfs.ext4 -L ROOT /dev/mapper/root

# Mount
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L BOOT /mnt/boot

# Installation
vi /etc/pacman.d/mirrorlist
# Move server of choice to the top
pacstrap /mnt base base-devel bash-completion intel-ucode iwd
genfstab -L /mnt >> /mnt/etc/fstab

# Configuration
arch-chroot /mnt
echo hostname > /etc/hostname
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock -w
echo LANG=en_US.UTF-8 > /etc/locale.conf
vi /etc/locale.gen
# Uncomment en_US.UTF-8 UTF-8
locale-gen

# Bootloader
bootctl install
vi /boot/loader/loader.conf
# default arch
# timeout 0
# editor  0
vi /boot/loader/entries/arch.conf
# title	  Arch Linux
# linux	  /vmlinuz-linux
# initrd  /intel-ucode.img
# initrd  /initramfs-linux.img
# options cryptdevice=/dev/nvme0n1p2:root
# options cryptkey=LABEL=USB:vfat:key
# options root=LABEL=ROOT rw
# options loglevel=3
# options nowatchdog
# options module_blacklist=btusb,iTCO_vendor_support,iTCO_wdt,sdhci,uvcvideo

# Initramfs
vi /etc/mkinitcpio.conf
# MODULES=(vfat)
# HOOKS=(base udev autodetect modconf block keyboard encrypt filesystems fsck)
mkinitcpio -p linux

# User
EDITOR=vi visudo
# Uncomment %wheel ALL=(ALL) ALL
useradd -mG wheel username
passwd usename
passwd
passwd -l root

# Exit
exit
umount -R /mnt
reboot
