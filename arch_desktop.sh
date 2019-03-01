#!/usr/bin/env bash

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a aleks -J %I $TERM

# Mirrorlist
sudo systemctl start dhcpcd.service
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme biber compton firefox git hsetroot htop libreoffice-fresh light neovim networkmanager noto-fonts-cjk numlockx perl-authen-sasl pulsemixer scrot shellcheck texlive-bibtexextra texlive-core ttf-dejavu ufw xorg-server xorg-xsetroot xorg-xinit xsel zathura-pdf-poppler # nvidia
sudo pacman -Rns dhcpcd nano netctl vi

# Config
sudo systemctl stop dhcpcd.service
sudo systemctl enable --now NetworkManager.service systemd-timesyncd.service ufw.service
sudo ufw enable
sudo localectl set-x11-keymap de pc105 nodeadkeys caps:swapescape

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs
cd .. && rm -rf yay
yay -S dropbox flat-remix-git i3lock-blur nerd-fonts-ubuntu-mono xbanish

# Dotfiles
mkdir Projects/ && cd Projects/ || exit
git clone https://github.com/astier/dotfiles
sh dotfiles/install.sh
. dotfiles/dotfiles/.bashrc

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
conda update --all
# conda create -n isy jupyter keras matplotlib pandas scikit-learn

# Suckless
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean

# Neovim
conda create -n nvi psutil
conda activate nvi
pip install neovim-remote pynvim
conda install -c conda-forge black
conda update --all
# conda activate isy
# conda install isort jedi pylint rope
# pip install python-language-server
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall

# Projects
cd ~/Projects/ || exit
git clone https://github.com/astier/arch-installer
git clone https://github.com/astier/scripts
sh scripts/install.sh
