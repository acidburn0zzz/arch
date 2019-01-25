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
sudo pacman -S arc-gtk-theme cinnamon eog evince firefox git gnome-screenshot gnome-terminal htop nemo-fileroller neofetch numlockx ttf-baekmuk ttf-dejavu ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager.service systemd-timesyncd.service ufw.service
pacman -Rns nano netctl

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
. .bashrc && conda update --all
conda create -n isy jupyter keras matplotlib pandas scikit-learn

# Projects
mkdir ~/Projects && cd ~/Projects
git clone https://github.com/astier/arch-installer
git clone https://github.com/astier/scripts
git clone https://github.com/astier/dotfiles
cd dotfiles && sh install.sh

# Neovim
pacman -S biber ctags neovim powerline shellcheck texlive-bibtexextra texlive-core
pip install pynvim
yay -S nerd-fonts-dejavu-complete
conda activate isy
conda install isort jedi pylint
conda install -c conda-forge black pudb python-language-server
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall
sudo pacman -Rns vi
