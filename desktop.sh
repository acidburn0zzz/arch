#!/usr/bin/env sh

# INTERNET
sudo cp -fr ~/projects/dotfiles/dotfiles/systemd/network /etc/systemd
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# PACKAGES
sudo pacman -S arc-gtk-theme ctags dash dmenu fakeroot firefox fzf gcc herbstluftwm light make neovim noto-fonts-cjk pulsemixer sx sxhkd tmux ttf-dejavu xorg-server xsel yarn

# PROJECTS
cd ~/projects || exit
git clone https://github.com/astier/st
cd ../st && sudo make install clean
cd ../dotfiles && sh setup.sh

# AUR
cd && git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
yay -S dropbox flat-remix neovim-remote

# CONFIGURE
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
chsh -s /bin/dash
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable fstrim.timer iptables.service systemd-timesyncd.service

# CLEAN
sudo pacman -Rns diffutils dhcpcd efibootmgr gettext go inetutils iproute2 iputils jfsutils licenses logrotate lvm2 man-pages mdadm nano netctl pciutils psmisc reiserfsprogs s-nail usbutils vi which xfsprogs
sudo pacman -Sc
cd && rm -fr yay .bash_logout .cache/go-build

sudo reboot
