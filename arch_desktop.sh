#!/usr/bin/env bash

# Mirrorlist
systemctl start dhcpcd.service
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme biber compton feh firefox git iwd light neovim noto-fonts-cjk pulsemixer scrot texlive-bibtexextra texlive-core ttf-dejavu ufw xdg-utils xorg-server xorg-xinit xorg-xsetroot xsel zathura-pdf-poppler
sudo pacman -Rns dhcpcd nano netctl vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs
cd .. && rm -fr yay
yay -S dropbox flat-remix-git i3lock-blur nerd-fonts-ubuntu-mono xbanish

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda.bak
conda update --all
# conda create -n isy jupyter keras matplotlib pandas scikit-learn

# Neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
conda create -n nvi psutil
conda activate nvi
pip install neovim-remote # black
# conda activate isy
# conda install isort jedi pylint rope
# pip install python-language-server

# Dotfiles & Projects
mkdir ~/Projects/
cd ~/Projects/
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
sh dotfiles/install.sh
sh scripts/install.sh

# Suckless
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean
sudo ln /usr/local/bin/st /usr/bin/xterm

# Network
sudo systemctl enable ead.service iwd.service systemd-networkd.service systemd-resolved.service systemd-timesyncd.service ufw.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo ufw enable

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a aleks -J %I $TERM

# TODO fix keymaps in xinitrc
