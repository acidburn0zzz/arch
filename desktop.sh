#!/usr/bin/env sh

# INTERNET
sudo cp -fr ~/projects/dotfiles/dotfiles/systemd/network /etc/systemd
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# PACKAGES
sudo pacman -S reflector
sudo reflector -p https -f16 -l8 --score 4 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme ctags dash firefox fzf light neovim noto-fonts-cjk pulsemixer slock tmux ttf-dejavu unclutter xcompmgr xorg-server xorg-xinit xsel
sudo pacman -Rns dhcpcd nano netctl s-nail vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd .. && rm -fr yay .config/go-build
sudo pacman -Rns go
yay -S dropbox

# PROJECTS
cd ~/projects
git clone https://github.com/astier/arch
git clone https://github.com/astier/scripts
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh

# SUCKLESS
mkdir ~/projects/suckless && cd ~/projects/suckless
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean

# CONFIGURATION
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable systemd-timesyncd.service

sudo reboot
