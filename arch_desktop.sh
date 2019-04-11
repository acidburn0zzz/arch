#!/usr/bin/env bash

# Internet
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf
# Establish internet-connection via iwd

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a aleks -J %I $TERM

# Packages
sudo pacman -S arc-gtk-theme biber compton feh firefox git light neovim noto-fonts-cjk perl-authen-sasl pulsemixer reflector scrot texlive-bibtexextra texlive-core ttf-dejavu ufw xdg-utils xorg-server xorg-xinit xorg-xsetroot xsel zathura-pdf-poppler # nvidia
sudo pacman -Rns dhcpcd nano netctl s-nail vi

# Misc
sudo systemctl enable --now systemd-timesyncd.service ufw.service
sudo ufw enable
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs
cd .. && rm -fr yay
yay -S dropbox flat-remix-git i3lock-blur nerd-fonts-ubuntu-mono xbanish

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda.bak
. .bashrc
conda update --all
# conda create -n isy jupyter keras matplotlib pandas scikit-learn

# Neovim
curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
conda create -n nvi psutil
conda activate nvi
pip install neovim-remote # black
conda deactivate
# conda activate isy
# conda install isort jedi pylint rope
# pip install python-language-server
# conda deactivate

# Suckless
mkdir Projects/
cd Projects/
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean
sudo ln /usr/local/bin/st /usr/bin/xterm

# Dotfiles & Scripts
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
cd ../dotfile && sh dotfiles/install.sh
cd ../scripts && sh scripts/install.sh

sudo reboot
