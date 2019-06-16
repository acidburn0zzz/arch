#!/usr/bin/env sh

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a username -J %I $TERM

# Internet
# If ethernet is not available establish connection via iwd
sudo systemctl enable --now ead.service iwd.service
sudo systemctl start dhcpcd.service

# Packages
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme biber dash firefox fzf git hsetroot light neovim noto-fonts-cjk perl-authen-sasl pulsemixer scrot slock texlive-bibtexextra tmux ttf-dejavu ufw unclutter xorg-server xorg-xinit xsel # nvidia
sudo pacman -Rns nano netctl s-nail vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd && rm -fr yay

# Projects
mkdir Projects .config
cd Projects/ || exit 1
git clone https://github.com/astier/arch
git clone https://github.com/astier/dotfiles
git clone https://github.com/astier/scripts
git clone https://github.com/astier/suckless
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh
cd ../suckless && sh setup.sh

# Neovim
sudo pacman -S ctags shellcheck shfmt yarn
yay -S neovim-remote
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh

# Internet
sudo systemctl stop dhcpcd.service
sudo pacman -Rns dhcpcd
sudo systemctl enable systemd-networkd.service systemd-resolved.service ufw.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf
sudo ufw enable

# Misc
sudo ln -sfT dash /usr/bin/sh
sudo ln /usr/local/bin/st /usr/bin/xterm
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable systemd-timesyncd.service

sudo reboot

# Dropbox
# gpg --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E
# yay -S dropbox
# systemctl --user enable dropbox.service
