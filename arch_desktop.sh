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
sudo pacman -S arc-gtk-theme biber cinnamon eog evince firefox git gnome-screenshot gnome-terminal htop libreoffice-fresh nemo-fileroller neovim numlockx shellcheck texlive-bibtexextra texlive-core ttf-dejavu ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager.service systemd-timesyncd.service ufw.service
pacman -Rns nano netctl vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S bashmarks-git dropbox flat-remix-git

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
. .bashrc && conda update --all
conda create -n isy jupyter keras matplotlib pandas scikit-learn

# Projects
mkdir ~/Projects && cd ~/Projects || exit
git clone https://github.com/astier/arch-installer
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
git clone https://github.com/astier/templates
cd dotfiles && sh install.sh

# Neovim
yay -S nerd-fonts-dejavu-complete
conda create -n nvi python
conda activate nvi
conda install -c conda-forge black pynvim
conda update --all
conda activate isy
conda install isort jedi pylint rope
pip install python-language-server
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
