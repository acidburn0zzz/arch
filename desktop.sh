#!/usr/bin/env sh

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a username -J %I $TERM

# Internet
# Setup networkd first (see arch-wiki)
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# Packages
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme biber ctags dash dunst firefox fzf git hsetroot light neovim noto-fonts-cjk perl-authen-sasl pulsemixer scrot slock shellcheck shfmt texlive-bibtexextra tmux ttf-dejavu ufw unclutter xcompmgr xorg-server xorg-xinit xorg-xsetroot xsel yarn # nvidia
sudo pacman -Rns dhcpcd nano netctl s-nail vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd .. && rm -fr yay
yay -S dropbox flat-remix neovim-remote nerd-fonts-ubuntu-mono

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

# Projects
mkdir Projects && cd Projects || exit 1
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh

# Suckless
cd ~/Projects && mkdir suckless && cd suckless || exit
git clone https://git.suckless.org/sites
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../dwm && sudo make install clean
cd ../st && sudo make install clean

# Configuration
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo ln -sfT dash /usr/bin/sh
sudo ln /usr/local/bin/st /usr/bin/xterm
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable systemd-timesyncd.service ufw.service
sudo ufw enable

sudo reboot
