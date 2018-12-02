#!/bin/bash

# Mirrorlist
sudo systemctl start dhcpcd
sudo pacman -S reflector
sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme cinnamon eog evince firefox git gnome-screenshot gnome-terminal htop nemo-fileroller numlockx pycharm-community-edition ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager systemd-timesyncd.service ufw.service

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git

# Dotfiles
cd && mkdir .config Projects && cd Projects
git clone https://github.com/astier/dotfiles.git
cd dotfiles && sh install.sh

# Miniconda
cd && curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
conda update --all

reboot

# TODO silent-boot
