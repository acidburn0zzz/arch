#!/usr/bin/env sh

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a username -J %I $TERM

# Internet
# If ethernet not available establish internet connection via iwd
sudo systemctl enable --now ead.service iwd.service
sudo systemctl start dhcpcd.service

# Mirrorlist
sudo pacman -S reflector
sudo reflector -p https -f16 -l8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme biber compton dash evince feh firefox fzf git light nautilus neovim noto-fonts-cjk newsboat perl-authen-sasl pulsemixer scrot shellcheck shfmt slock texlive-bibtexextra tmux ttf-dejavu ufw unclutter xorg-server xorg-xinit xsel # nvidia
sudo pacman -Rns nano netctl s-nail vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs
cd && rm -fr yay
yay -S flat-remix

# Projects
mkdir Projects/
cd Projects/ || exit 1
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/scripts
git clone https://github.com/astier/st
cd dotfiles && sh install.sh
cd ../scripts && sh install.sh
cd ../dmenu && sudo make install clean
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean
sudo ln /usr/local/bin/st /usr/bin/xterm

# Neovim
sudo pacman -S ctags nodejs yarn
yay -S neovim-remote
yarn global add neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall

# networkd & resolved
sudo systemctl stop dhcpcd.service
sudo pacman -Rns dhcpcd
sudo systemctl enable systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# Misc
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable systemd-timesyncd.service ufw.service
sudo ufw enable

sudo reboot

# # Dropbox
# gpg --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
# yay -S dropbox
# systemctl --user enable dropbox.service
# (dropbox &)

# # Miniconda
# curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# sh Miniconda3-latest-Linux-x86_64.sh
# rm Miniconda3-latest-Linux-x86_64.sh
