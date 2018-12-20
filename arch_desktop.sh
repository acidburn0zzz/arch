#!/bin/bash

# TODO set x-keymap

# Mirrorlist
sudo systemctl start dhcpcd
sudo pacman -S reflector
sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme cinnamon eog firefox git gnome-screenshot gnome-terminal htop nemo-fileroller neovim numlockx ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager systemd-timesyncd.service ufw.service
sudo pacman -Rns nano netctl vi

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git

#VSC
sudo pacman -S ctags npm
sudo npm --unsafe-perm i -g bash-language-server
yay -S visual-studio-code-bin
code --install-extension davidanson.vscode-markdownlint
code --install-extension dunstontc.viml
code --install-extension equinusocio.vsc-material-theme
code --install-extension formulahendry.code-runner
code --install-extension mads-hartmann.bash-ide-vscode
code --install-extension ms-python.python
code --install-extension pkief.material-icon-theme
code --install-extension rogalmic.bash-debug
code --install-extension shakram02.bash-beautify
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension visualstudioexptteam.vscodeintellicode

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
conda update --all
conda create -n isy autopep8 keras matplotlib pandas pylint rope scikit-learn
conda clean -ay

# Dotfiles
mkdir ~/Projects && cd ~/Projects
git clone https://github.com/astier/dotfiles.git
cd dotfiles && sh install.sh
