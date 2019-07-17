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
pacstrap /mnt base base-devel bash-completion efibootmgr git intel-ucode iwd
genfstab -L /mnt >> /mnt/etc/fstab

# CONFIGURE
arch-chroot /mnt
chattr +i /var/log/lastlog
echo hostname > /etc/hostname
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock -w
echo LANG=en_US.UTF-8 > /etc/locale.conf
 vi /etc/locale.gen
# Uncomment en_US.UTF-8 UTF-8
locale-gen

# USER
EDITOR=vi visudo
# Uncomment %wheel ALL=(ALL) ALL
useradd -mG wheel username
passwd usename
passwd

# EFISTUB
mkdir /home/aleks/projects
cd /home/aleks/projects || exit
git clone https://github.com/astier/scripts
sh scripts/scripts/efistub.sh

# MKINITCPIO
git clone https://github.com/astier/dotfiles
chown -R aleks /home/aleks/projects
cp -f dotfiles/dotfiles/mkinitcpio.conf /etc
mkinitcpio -p linux

# REBOOT
exit
umount -R /mnt
reboot
