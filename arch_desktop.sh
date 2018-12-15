#!/bin/bash

# Mirrorlist
sudo systemctl start dhcpcd
sudo pacman -S reflector
sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme cinnamon eog firefox git gnome-screenshot gnome-terminal htop nemo-fileroller numlockx ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager systemd-timesyncd.service ufw.service

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git

# Dotfiles
mkdir ~/Projects && cd ~/Projects
git clone https://github.com/astier/dotfiles.git
cd dotfiles && sh install.sh

# Scripts
cd ~/Projects
git clone https://github.com/astier/scripts.git
cd scripts && sh install.sh

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
