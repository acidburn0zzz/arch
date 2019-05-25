#!/usr/bin/env sh

# Internet
sudo systemctl start dhcpcd.service
sudo systemctl enable --now ead.service iwd.service
# Establish internet connection via iwd

# Mirrorlist
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme compton ctags dash feh firefox fzf git light neovim nodejs pulsemixer slock tmux ttf-dejavu ufw unclutter xorg-server xorg-xinit xsel yarn # nvidia
# biber mpv noto-fonts-cjk perl-authen-sasl scrot shellcheck shfmt texlive-bibtexextra youtube-dl zathura-pdf-poppler
sudo pacman -Rns nano netctl s-nail vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs
cd .. && rm -fr yay
yay -S dropbox neovim-remote

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

# Config
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 intl caps:swapescape
sudo systemctl enable systemd-timesyncd.service ufw.service
sudo ufw enable
systemctl --user enable dropbox.service

# Neovim
yarn global add neovim
curl -fLo .local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim -c PlugInstall

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

# networkd & resolved
sudo systemctl stop dhcpcd.service
sudo pacman -Rns dhcpcd
sudo systemctl enable --now systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a username -J %I $TERM

sudo reboot
