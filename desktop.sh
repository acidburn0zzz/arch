#!/usr/bin/env sh

# INTERNET
sudo cp -fr ~/projects/dotfiles/dotfiles/systemd/network /etc/systemd
sudo systemctl enable --now ead.service iwd.service systemd-networkd.service systemd-resolved.service
sudo ln -fs /run/systemd/resolve/resolv.conf /etc/resolv.conf

# PACKAGES
sudo pacman -S reflector
sudo reflector -p https -f16 -l8 --score 4 --sort rate --save /etc/pacman.d/mirrorlist
sudo pacman -S arc-gtk-theme dash fakeroot firefox gcc light make neovim pkgconf pulsemixer python-neovim tmux ttf-dejavu xcompmgr xorg-server xorg-xinit xsel yarn
sudo pacman -Rns diffutils dhcpcd efibootmgr gettext iproute2 iputils jfsutils licenses logrotate lvm2 man-pages mdadm nano netctl pciutils psmisc reiserfsprogs s-nail usbutils vi which xfsprogs
rm ~/.bash_logout

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -is
sudo pacman -Rns go
cd .. && rm -fr yay .cache/go-build
yay -S dropbox

# PROJECTS
cd ~/projects || exit
git clone https://github.com/astier/arch
cd dotfiles && sh setup.sh
cd ../scripts && sh setup.sh

# SUCKLESS
mkdir ~/projects/suckless && cd ~/projects/suckless || exit
git clone https://git.suckless.org/sites
git clone https://github.com/astier/dmenu
git clone https://github.com/astier/dwm
git clone https://github.com/astier/st
cd dmenu/src && sudo make install clean
cd ../../dwm/src && sudo make install clean
cd ../../st && sh setup.sh

# CONFIGURATION
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
chsh -s /bin/dash
sudo ln -sfT dash /usr/bin/sh
sudo localectl set-x11-keymap us pc105 altgr-intl caps:swapescape
sudo systemctl enable fstrim.timer systemd-timesyncd.service

sudo reboot
