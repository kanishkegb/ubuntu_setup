#!/bin/bash

## define colors
RED='\033[0;31m'
YEL='\033[0;33m'
NC='\033[0m' # No Color

## settings
reset
echo -e "${YEL}Starting to change settings ${NC}"
echo "change enabled=0"
sudo gedit /etc/default/apport


## system update
echo -e "${YEL}Starting to update the system ${NC}"
sudo apt-get -y update
sudo apt-get -y upgrade


## apps
echo ""
echo ""
echo -e "${YEL}Starting to install apps ${NC}"

# vlc
echo ""
echo -e "${YEL}Installing VLC ${NC}"
sudo apt-get -y install vlc

# jabref
echo ""
echo -e "${YEL}Installing JabRef ${NC}"
sudo apt-get -y install jabref

# texstudio
# echo ""
# echo -e "${YEL}Installing TexStudio ${NC}"
# sudo apt-add-repository ppa:blahota/texstudio
# sudo apt-get -y update
# sudo apt-get -y install texstudio

# git
echo ""
echo -e "${YEL}Installing git ${NC}"
sudo apt-get -y purge runit
sudo apt-get -y purge git-all
sudo apt-get -y purge git
sudo apt-get -y autoremove
sudo apt -y update
sudo apt -y install git
                                                                                                │ishke-XPS"
echo ""                                                                                         │ 13:11:32  powerline-shell  ⚓ v0.4.1-18-g7f837ed  ✎  %  gcam "added PowerlineSymbols.otf t
echo -e "${YEL}Setting up git params ${NC}"                                                     │o gitignore"
git config --global user.email "kanishkegb@gmail.com"                                           │[detached HEAD 0d9307d] added PowerlineSymbols.otf to gitignore
git config --global push.default matching

# update git submodules
git submodule update --init

# tmux
echo ""
echo -e "${YEL}Installing tmux ${NC}"
sudo apt-get -y install tmux
cp .tmux.conf ~/

# weather widget
echo ""
echo -e "${YEL}Installing Weather Widget ${NC}"
sudo add-apt-repository ppa:atareao/atareao
sudo apt-get update
sudo apt-get -y install my-weather-indicator

# red-shift
sudo apt-get -y install redshift-gtk

# invert color space
echo ""
echo -e "${YEL}Installing xcalib ${NC}"
sudo apt-get -y install xcalib

# g-parted
echo ""
echo -e "${YEL}Installing gparted ${NC}"
sudo apt-get -y install gparted

# pip
echo ""
echo -e "${YEL}Installing pip ${NC}"
sudo apt-get -y install python-pip python3-pip

# powerline
echo ""
echo -e "${YEL}Installing powerline ${NC}"
pip install --user powerline-status
cd powerline-shell
sudo python setup.py install

# powerline fonts
echo ""
echo -e "${YEL}Installing powrline fonts ${NC}"
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mv PowerlineSymbols.otf ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/
mkdir -p ~/.config/fontconfig/conf.d/
mv -powerline-symbols.conf ~/.config/fontconfig/conf.d/
cd ..

# install curl
echo ""
echo -e "${YEL}Installing curl ${NC}"
sudo apt-get -y install curl

# install oh-my-zsh
echo ""
echo -e "${YEL}Installing zsh ${NC}"
sudo apt-get -y install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install tmux addons
echo ""
echo -e "${YEL}Installing tmux addons ${NC}"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# install Sinhala
echo ""
echo -e "${YEL}Installing Sinhala ${NC}"
sudo apt-get -y install ibus-m17n

# copying dotfiles
echo ""
echo -e "${YEL}Copying dotfiles ${NC}"
echo "cp .bashrc ~/"
echo "cp .zshrc ~/"
echo "cp .tmux.conf ~/"
echo "cp .powerline-shell.json ~/"

echo "DEFAULT_USER = $USER prompt_context(){}" >> ~/.zshrc

# uniform-icons theme
# sudo add-apt-repository ppa:noobslab/icons2
# sudo apt-get update
# sudo apt-get install uniform-icons

# other apps to be installed manually
echo ""
echo ""
echo -e "${YEL}Install these apps manually ${NC}"
echo "atom: https://atom.io/download/deb"
echo "gitkraken: https://www.gitkraken.com/download"
echo "anaconda: https://www.continuum.io/downloads"

# manual settings
echo ""
echo ""
echo -e "${YEL}Change these settings manually${NC}"
echo "Add shortcut Super+Ctrl+C for xcalib -invert -alter"
echo "Add solarized_light to ~/.config/texstudio/texstudio.ini"
echo "Add the Sinhala keyboard in Language Settings"
echo "Install tmux plugins by pressing 'prefix+I'"
