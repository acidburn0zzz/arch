#!/usr/bin/env bash

# Autologin
sudo systemctl edit getty@tty1.service
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a aleks -J %I $TERM

# Mirrorlist
sudo systemctl start dhcpcd.service
sudo pacman -S reflector
sudo reflector -p https -f32 -l16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme biber cinnamon eog evince firefox git gnome-screenshot gnome-terminal htop nemo-fileroller neovim numlockx texlive-bibtexextra texlive-core ttf-baekmuk ttf-dejavu ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager.service systemd-timesyncd.service ufw.service
pacman -Rns nano netctl vi

# AUR
git clone https://aur.archlinux.org/yay
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh .bashrc-miniconda3.bak
. .bashrc && conda update --all
conda create -n isy jupyter keras matplotlib pandas scikit-learn

# VSCode
yay -S ttf-twemoji-color visual-studio-code-bin
sudo pacman -S ctags xdg-utils
conda activate isy
conda install pylint rope
pip install black
code --install-extension arcticicestudio.nord-visual-studio-code
code --install-extension davidanson.vscode-markdownlint
code --install-extension donjayamanne.githistory
code --install-extension dunstontc.viml
code --install-extension equinusocio.vsc-material-theme
code --install-extension formulahendry.code-runner
code --install-extension james-yu.latex-workshop
code --install-extension ms-python.python
code --install-extension pkief.material-icon-theme
code --install-extension pnp.polacode
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension vscodevim.vim
code --install-extension yzhang.markdown-all-in-one

# Projects
mkdir ~/Projects && cd ~/Projects
git clone https://github.com/astier/arch-installer
git clone https://github.com/astier/scripts
git clone https://github.com/astier/dotfiles
cd dotfiles && sh install.sh
