#!/bin/bash

## Começando meu shellscript ##

sudo rm/var/lib/dpkg/lock-frontend ; sudo rm/var/cache/apt/archives/lock ;

## atualizar repositorio ##

sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get dist-upgrade -y

## instalando gcc ##

sudo apt-get install gcc -y
sudo apt-get install make -y

sudo apt --fix-broken install -y

## criando pasta paraprogramas baixados ##

mkdir /home/matheuznsilva/Downloads/progamas

cd /home/matheuznsilva/Downloads/progamas

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -c https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.21.4_amd64.deb

sudo dpkg -i *.deb

## Programas do repositório ##

sudo apt-add-repository ppa:graphics-drivers/ppa  -y
sudo apt-get update
sudo apt install htop -y
sudo apt install flatpak -y
sudo apt install snapd -y
sudo apt-get update
sudo snap install spotify
sudo snap install gnome-calendar
sudo snap install code --classic
##sudo snap install eclipse --classic
##sudo snap install skype --classic
##sudo snap install android-studio --classic
sudo snap install photogimp
sudo snap install sublime-text --classic
sudo snap install vlc
sudo snap install onlyoffice-desktopeditors
sudo snap install thunderbird
sudo snap install telegram-desktop


## install Tweak Tools

sudo apt install gnome-tweak-tool gnome-shell-extensions chrome-gnome-shell -y

## install Tor 

sudo apt install torbrowser-launcher -y

## install LaTex

sudo apt-get install texlive-full -y
sudo apt-get install texstudio -y

## INSTALL ALBERT LAUNCHER ##
sudo curl "https://build.opensuse.org/projects/home:manuelschneid3r/public_key" | sudo apt-key add -
echo 'deb http://download.opensuse.org/repositories/home:/manuelschneid3r/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:manuelschneid3r.list
curl -fsSL https://download.opensuse.org/repositories/home:manuelschneid3r/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_manuelschneid3r.gpg > /dev/null
sudo apt update
sudo apt install albert -y

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #
## Finalização, atualização e limpeza##
sudo apt update && sudo apt dist-upgrade -y
flatpak update
sudo apt autoclean
sudo apt autoremove -y
# ---------------------------------------------------------------------- #

reboot
