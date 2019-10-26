#!/usr/bin/env sh

# INTERNET
sudo cp -fr ~/projects/dotfiles/dotfiles/systemd/network /etc/systemd
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# PACKAGES
sudo pacman -S arc-gtk-theme dash fakeroot firefox fzf gcc herbstluftwm light make man-db noto-fonts-cjk pulsemixer python-pynvim sx sxhkd tmux ttf-dejavu xorg-server xsel yarn
cd && git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
yay -S dropbox

# PROJECTS
cd ~/projects || exit
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/slock
git clone https://github.com/astier/st
cd dmenu && sudo make install clean
cd ../slock && sudo make install clean
cd ../st && sudo make install clean

# CONFIGURE
cd ~/projects/dotfiles && sh setup.sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
chsh -s /bin/dash
sudo ln -sfT dash /usr/bin/sh
sudo systemctl enable fstrim.timer iptables.service systemd-timesyncd.service

# CLEAN
sudo pacman -Rns efibootmgr fakeroot gcc go make
sudo pacman -Sc
cd && rm -fr .bash_logout .cache/go-build yay

sudo reboot
