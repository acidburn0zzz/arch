#!/usr/bin/env sh

# INTERNET
sudo cp -fr ~/projects/dotfiles/dotfiles/systemd/network /etc/systemd
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# INSTALL
utils -u
sudo pacman -S arc-gtk-theme dash fakeroot firefox gcc light make neovim pkgconf python-neovim tmux ttf-dejavu xcompmgr xorg-server xorg-xinit xsel yarn

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
cd .. && rm -fr yay
yay -S dropbox

# SUCKLESS
mkdir ~/projects/suckless && cd ~/projects/suckless || exit
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu/src && sudo make install clean
cd ../../dwm/src && sudo make install clean
cd ../../st && sh setup.sh

# CONFIGURATION
cd ~/projects/dotfiles && sh setup.sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
chsh -s /bin/dash
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable fstrim.timer systemd-timesyncd.service

# CLEAN
sudo pacman -Rns diffutils dhcpcd gettext iproute2 iputils jfsutils licenses logrotate lvm2 man-pages mdadm nano netctl psmisc reiserfsprogs s-nail usbutils vi which xfsprogs
utils -c
rm ~/.bash_logout ~/.cache/go-build

sudo reboot
