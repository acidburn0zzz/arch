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
sudo pacman -S arc-gtk-theme biber cinnamon eog evince firefox git gnome-screenshot gnome-terminal htop nemo-fileroller neofetch neovim numlockx powerline shellcheck texlive-bibtexextra texlive-core ttf-baekmuk ttf-dejavu ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager.service systemd-timesyncd.service ufw.service

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git nerd-fonts-dejavu-complete ttf-twemoji-color

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
. .bashrc && conda update --all
conda create -n isy autopep8 jupyter keras matplotlib pandas pylint scikit-learn

# Neovim
pip install pynvim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo pacman -Rns nano vi

# Projects
mkdir ~/Projects && cd ~/Projects
git clone https://github.com/astier/arch-installer
git clone https://github.com/astier/scripts
git clone https://github.com/astier/dotfiles
cd dotfiles && sh install.sh
