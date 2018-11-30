#!/bin/bash

# Mirrorlist
sudo systemctl start dhcpcd
sudo pacman -S reflector
sudo reflector -p https -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme cinnamon firefox git gnome-terminal nemo-fileroller ufw xorg-server xorg-xinit # eog evince htop nvidia pycharm-community-edition
sudo systemctl enable NetworkManager systemd-timesyncd.service ufw.service

# AUR TODO write custom scripts / AUR helper
mkdir AUR && cd AUR
git clone https://aur.archlinux.org/flat-remix-git.git
cd flat-remix-git && makepkg -Ccirs && cd ..
git clone https://aur.archlinux.org/dropbox.git
cd dropbox && makepkg -Ccirs

# Dotfiles
cd && mkdir .config Projects && cd Projects
git clone https://github.com/astier/arch-installer.git
git clone https://github.com/astier/dotfiles.git
cd dotfiles && sh install.sh

# Miniconda
cd && curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
conda update --all

reboot

# TODO health-check
# TODO silent-boot
# TODO system-cleaner
