#!/bin/bash

## STARTING SHELLSCRIPT ##

## INITIAL UPDATE ##
sudo rm/var/lib/dpkg/lock-frontend ; sudo rm/var/cache/apt/archives/lock ;
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt install ubuntu-restricted-extras -y

## GCC INSTALL ##
sudo apt-get install gcc -y
sudo apt-get install make -y

## .DEB FILES ##
mkdir ~/Downloads/progamas
cd ~/Downloads/progamas

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -c https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.21.4_amd64.deb
wget -c https://github.com/cerebroapp/cerebro/releases/download/v0.5.0/cerebro_0.5.0_amd64.deb -O cerebro.deb 
#wget -c https://launchpadlibrarian.net/319770251/pulseeffects_1.313entornosgnulinuxenial-1ubuntu1_amd64.deb
#wget -qO- <https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh> | bash
sudo apt --fix-broken install -y
sudo dpkg -i *.deb
sudo apt --fix-broken install -y
sudo dpkg -i *.deb

cd ~/

## REPOSITORY PROGRAMS ##
##sudo add-apt-repository ppa:nilarimogard/webupd8 -y && sudo apt-get update && sudo apt-get install pulseaudio-equalizer -y
sudo apt-add-repository ppa:graphics-drivers/ppa -y && sudo apt install nvidia-driver-470 -y
sudo apt-get update
sudo apt install htop -y
sudo apt install flatpak -y
sudo apt install snapd -y
sudo apt install curl -y
sudo apt install stacer -y
sudo apt-get update

## DEV PROGRAMS ##
sudo snap install code --classic
##sudo apt install openjdk-17-jre-headless -y
sudo snap install flutter --classic
sudo snap install sublime-text --classic
sudo snap install android-studio --classic
#sudo snap install eclipse --classic
sudo snap install brackets --classic


## PRODUCTION PROGRAMS ##
sudo snap install gnome-calendar
sudo snap install thunderbird
sudo snap install onlyoffice-desktopeditors
##sudo snap install skype --classic
sudo snap install telegram-desktop

## MULTIMEDIA PROGRAMS ##
sudo snap install spotify
sudo snap install photogimp
sudo snap install vlc

## INSTALL TWEAK TOOLS AND GNOME EXTENSIONS
sudo apt install gnome-tweak-tool gnome-shell-extensions chrome-gnome-shell -y

## INSTALL TOR BROWSER
sudo apt install torbrowser-launcher -y

## INSTALL LATEX
sudo apt-get install texlive-full -y
sudo apt-get install texstudio -y

## INSTALL FONT FINDER ##
flatpak install --user https://flathub.org/repo/appstream/io.github.mmstick.FontFinder.flatpakref -y
flatpak --user update io.github.mmstick.FontFinder -y

# ----------------------- FINISHING INSTALLATION ----------------------- #
## Finalizing, updating and cleaning ##
sudo apt-get update && sudo apt-get upgrade -y && sudo apt full-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

sudo reboot