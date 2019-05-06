#!/usr/bin/env bash

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a username -J %I $TERM

# Internet
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf
# Establish internet-connection via iwd

# Packages
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme biber compton feh firefox git light neovim noto-fonts-cjk perl-authen-sasl pulsemixer scrot slock texlive-bibtexextra ttf-dejavu ufw unclutter xdg-utils xorg-server xorg-xinit xsel zathura-pdf-poppler # nvidia
sudo pacman -Rns dhcpcd nano netctl s-nail vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs
cd .. && rm -fr yay
yay -S dropbox neovim-remote

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

# Projects
mkdir Projects/
cd Projects/ || exit 1
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/dwm
git clone https://github.com/astier/scripts
git clone https://github.com/astier/st
cd dotfiles && sh install.sh
cd ../scripts && sh install.sh
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean
sudo ln /usr/local/bin/st /usr/bin/xterm

# Misc
curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo localectl set-x11-keymap de pc105 nodeadkeys caps:swapescape
sudo systemctl enable systemd-timesyncd.service ufw.service
sudo ufw enable
systemctl --user enable dropbox.service

sudo reboot
