#!/usr/bin/env sh

timedatectl set-ntp 1

# PARTITION
gdisk /dev/nvme0n1 # boot +2200 EF00, root
mkfs.vfat -F16 -n BOOT /dev/nvme0n1p1
mkfs.ext4 -L ROOT /dev/mapper/root

# ENCRYPT
mkdir usb
mount -L USB usb
cryptsetup luksFormat /dev/nvme0n1p2 -d usb/key
cryptsetup open /dev/nvme0n1p2 root -d usb/key

# MOUNT
mount -L ROOT /mnt
mkdir /mnt/boot
mount -L BOOT /mnt/boot

# INSTALL
pacstrap /mnt base bash-completion efibootmgr git intel-ucode iwd linux linux-firmware neovim sudo
genfstab -L /mnt >> /mnt/etc/fstab
vi /mnt/etc/fstab # Replace relatime with noatime,lazytime,commit=180

# CONFIGURE
arch-chroot /mnt
chattr +i /var/log/lastlog
echo hostname > /etc/hostname
ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock -w
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo en_US.UTF-8 UTF-8 >> /etc/locale.gen
locale-gen

# USER
EDITOR=vi visudo
# %wheel ALL=(ALL) ALL
# Defaults passwd_timeout=0
useradd -mG wheel username
passwd usename
passwd
passwd -l root

# BOOT
mkdir /home/usename/projects
cd /home/usename/projects || exit
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
chown -R usename /home/usename/projects
cp -f dotfiles/dotfiles/mkinitcpio.conf /etc
cd scripts && sh setup.sh
mkinitcpio -p linux
efistub

# REBOOT
exit
umount -R /mnt
reboot
