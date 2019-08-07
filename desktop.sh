#!/usr/bin/env sh

# INTERNET
sudo cp -fr ~/projects/dotfiles/dotfiles/systemd/network /etc/systemd
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# INSTALL
sudo pacman -S reflector
sudo reflector -p https -f16 -l8 --score 4 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme dash fakeroot firefox fzf gcc herbstluftwm light make neovim noto-fonts-cjk pkgconf pulsemixer python-neovim sxkhd tmux ttf-dejavu xcompmgr xorg-server xorg-xinit xsel yarn

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd .. && rm -fr yay
yay -S dropbox flat-remix

# PROJECTS
cd ~/projects || exit
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/st
cd dotfiles && sh setup.sh
cd ../dmenu && sudo make install clean
cd ../st && sudo make install clean

# CONFIGURATION
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable fstrim.timer systemd-timesyncd.service

# CLEAN
sudo pacman -Rns diffutils dhcpcd go iproute2 iputils jfsutils licenses logrotate lvm2 man-pages mdadm nano netctl psmisc reiserfsprogs s-nail usbutils vi which xfsprogs
sudo pacman -Sc
rm ~/.bash_logout ~/.cache/go-build

sudo reboot
