#!/usr/bin/env sh

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a username -J %I $TERM

# Packages
sudo systemctl start dhcpcd.service
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme biber cinnamon ctags dash firefox fzf git nemo-fileroller neovim noto-fonts-cjk scrot shellcheck shfmt texlive-bibtexextra tmux ttf-dejavu ufw xorg-server xorg-xinit xsel yarn # nvidia
sudo pacman -Rns dhcpcd nano netctl vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd .. && rm -fr yay
sudo pacman -Rns go
yay -S dropbox flat-remix neovim-remote

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

# Projects
mkdir Projects && cd Projects || exit 1
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
git clone https://github.com/astier/st
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh
cd ../st && sudo make install clean

# Configuration
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo ln -sfT dash /usr/bin/sh
sudo ln /usr/local/bin/st /usr/bin/xterm
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable NetworkManager.service systemd-timesyncd.service ufw.service
sudo enable ufw

sudo reboot
