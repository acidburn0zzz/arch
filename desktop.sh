#!/usr/bin/env sh

# INSTALL
sudo pacman -S reflector
sudo reflector -p https -f16 -l8 --score 4 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme cinnamon dash fakeroot firefox gnome-terminal neovim python-neovim tmux ttf-dejavu xorg-server xorg-xinit xsel yarn

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd .. && rm -fr yay
yay -S dropbox flat-remix

# CONFIGURATION
cd ~/projects/dotfiles && sh setup.sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
chsh -s /bin/dash
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable NetworkManager.service fstrim.timer systemd-timesyncd.service

# CLEAN
sudo pacman -Rns diffutils dhcpcd gettext iproute2 iputils jfsutils licenses logrotate lvm2 man-pages mdadm nano netctl psmisc reiserfsprogs s-nail usbutils vi which xfsprogs
sudo pacman -Sc
rm ~/.bash_logout ~/.cache/go-build

sudo reboot
