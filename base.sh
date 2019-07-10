#!/usr/bin/env sh

timedatectl set-ntp 1

# PARTITION
gdisk /dev/nvme0n1
# boot +550M EF00, root

# ENCRYPT
mkdir usb
mount -L USB usb
cryptsetup luksFormat /dev/nvme0n1p2 -d usb/key
cryptsetup open /dev/nvme0n1p2 root -d usb/key

# FILESYSTEM
mkfs.vfat -F16 -n BOOT /dev/nvme0n1p1
mkfs.ext4 -L ROOT /dev/mapper/root

# MOUNT
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L BOOT /mnt/boot

# INSTALL
pacstrap /mnt base base-devel bash-completion git intel-ucode iwd
genfstab -L /mnt >> /mnt/etc/fstab

# CONFIGURE
arch-chroot /mnt
echo hostname > /etc/hostname
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock -w
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen

# USER
EDITOR=vi visudo
# Uncomment %wheel ALL=(ALL) ALL
useradd -mG wheel username
passwd usename
passwd
passwd -l root

# BOOTLOADER
bootctl install
mkdir /home/aleks/projects
chown -R aleks /home/aleks/projects
cd /home/aleks/projects
git clone https://github.com/astier/dotfiles
cd dotfiles/dotfiles
cp -fr loader /boot
cp -f mkinitcpio.conf /etc
mkinitcpio -p linux

# REBOOT
exit
umount -R /mnt
reboot
