#!/usr/bin/env bash

localectl --no-convert set-x11-keymap de pc105

# Autologin
vi /etc/systemd/system/getty@tty1.service.d/override.conf
# [Service]
# ExecStart=
# ExecStart=-/usr/bin/agetty -a aleks -J %I $TERM

# Mirrorlist
sudo systemctl start dhcpcd
sudo pacman -S reflector
sudo reflector -p https -l64 -f16 --score 8 --sort rate --save /etc/pacman.d/mirrorlist

# Packages
sudo pacman -S arc-gtk-theme biber cinnamon eog evince firefox git gnome-screenshot gnome-terminal htop nemo-fileroller noto-fonts-emoji numlockx pandoc texlive-bibtexextra texlive-core ttd-dejavu ttf-baekmuk ufw xorg-server xorg-xinit # nvidia
sudo systemctl enable NetworkManager.service systemd-timesyncd.service ufw.service

# AUR
git clone https://aur.archlinux.org/yay.git
cd yay && makepkg -Ccirs && cd .. && rm -rf yay
yay -S dropbox flat-remix-git

# Miniconda
curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
sh Miniconda3-latest-Linux-x86_64.sh
rm Miniconda3-latest-Linux-x86_64.sh
conda create -n isy keras matplotlib pandas scikit-learn

# Neovim
sudo pacman -S neovim powerline-fonts
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
sudo pacman -Rns nano vi

# VSCode
yay -S visual-studio-code-bin
sudo pacman -S bash-language-server ctags shellcheck xdg-utils
conda activate isy
conda install pylint yapf
code --install-extension arcticicestudio.nord-visual-studio-code
code --install-extension davidanson.vscode-markdownlint
code --install-extension dougfinke.vscode-pandoc
code --install-extension dunstontc.viml
code --install-extension equinusocio.vsc-material-theme
code --install-extension formulahendry.code-runner
code --install-extension grapecity.gc-excelviewer
code --install-extension james-yu.latex-workshop
code --install-extension mads-hartmann.bash-ide-vscode
code --install-extension mechatroner.rainbow-csv
code --install-extension ms-python.python
code --install-extension pkief.material-icon-theme
code --install-extension pnp.polacode
code --install-extension rogalmic.bash-debug
code --install-extension rpinski.shebang-snippets
code --install-extension shakram02.bash-beautify
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension timonwong.shellcheck
code --install-extension visualstudioexptteam.vscodeintellicode
code --install-extension vscodevim.vim
code --install-extension yzhang.markdown-all-in-one

# Dotfiles
mkdir ~/Projects && cd ~/Projects || exit
git clone https://github.com/astier/dotfiles.git
cd dotfiles && sh install.sh
