#!/usr/bin/env bash

localectl --no-convert set-x11-keymap de pc105
vi /etc/systemd/system/getty@tty1.service.d/override.conf
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a aleks -J %I $TERM

# Mirrorlist
sudo systemctl start dhcpcd
sudo pacman -S reflector
sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme biber cinnamon eog firefox git gnome-screenshot gnome-terminal htop nemo-fileroller numlockx pandoc texlive-bibtexextra texlive-core ttd-dejavu ttf-baekmuk ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager.service systemd-timesyncd.service ufw.service
sudo pacman -Rns netctl nano

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
conda update --all
conda create -n isy keras matplotlib scikit-learn
conda clean -ay

# Dotfiles
mkdir ~/Projects && cd ~/Projects
git clone https://github.com/astier/dotfiles.git
cd dotfiles && sh install.sh
