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
pacstrap /mnt base base-devel bash-completion git intel-ucode iwd
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

# User
EDITOR=vi visudo
# Uncomment %wheel ALL=(ALL) ALL
useradd -mG wheel username
passwd usename
passwd
passwd -l root

# Bootloader
bootctl install
mkdir /home/aleks/projects
cd /home/aleks/projects
git clone https://github.com/astier/dotfiles
cd dotfiles/dotfiles
cp -f loader /boot
cp -f mkinitcpio.conf /etc
mkinitcpio -p linux

# Reboot
exit
umount -R /mnt
reboot
