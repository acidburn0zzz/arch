#!/usr/bin/env bash

# Set x- and tty-keymap
localectl --no-convert set-x11-keymap de pc105

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
sudo pacman -S arc-gtk-theme biber compton feh firefox git htop libreoffice-fresh light neovim networkmanager noto-fonts-cjk numlockx pulsemixer scrot shellcheck texlive-bibtexextra texlive-core ttf-dejavu ufw xorg-server xorg-xsetroot xorg-xinit zathura-pdf-poppler # nvidia
sudo systemctl stop dhcpcd.service
sudo systemctl enable --now NetworkManager.service systemd-timesyncd.service ufw.service
pacman -Rns dhcpcd nano netctl vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git i3lock-blur nerd-fonts-ubuntu-mono xbanish

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
. .bashrc && conda update --all
conda create -n isy jupyter keras matplotlib pandas scikit-learn

# Dotfiles
mkdir ~/Projects && cd ~/Projects || exit
git clone https://github.com/astier/arch-installer
git clone https://github.com/astier/scripts
git clone https://github.com/astier/dotfiles
cd dotfiles && sh install.sh
cd ../scripts && sh install.sh

# Suckless
cd ~/Projects
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
# git clone https://github.com/astier/slock
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../dwm && sudo make install clean
# cd ../slock && sudo make install clean
cd ../st && sudo make install clean

# Neovim
conda create -n nvi psutil python
conda activate nvi
conda install -c conda-forge black pynvim
pip install neovim-remote
conda update --all
conda activate isy
conda install isort jedi pylint rope
pip install python-language-server
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
