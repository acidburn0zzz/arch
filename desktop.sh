#!/usr/bin/env sh

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a username -J %I $TERM

# Internet
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo cp /etc/resolv.conf /etc/resolv.conf.bak
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# Packages
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme biber ctags dash firefox fzf git hsetroot light neovim noto-fonts-cjk perl-authen-sasl pulsemixer scrot shellcheck shfmt slock texlive-bibtexextra tmux ttf-dejavu ufw unclutter xorg-server xorg-xinit xsel yarn # nvidia
sudo pacman -Rns dhcpcd nano netctl vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd .. && rm -fr yay
yay -S dropbox neovim-remote
systemctl --user enable dropbox.service

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

# Configuration
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable systemd-timesyncd.service ufw.service
sudo enable ufw

# Projects
mkdir Projects
cd Projects/ || exit 1
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
git clone https://github.com/astier/suckless
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh
cd ../suckless && sh setup.sh

sudo reboot
