#!/bin/bash

## Começando meu shellscript ##

sudo rm/var/lib/dpkg/lock-frontend ; sudo rm/var/cache/apt/archives/lock ;

## atualizar repositorio ##

sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get dist-upgrade -y

sudo apt install git -y

## criando pasta paraprogramas baixados ##

mkdir /home/$USER/Downloads/progamas

cd /home/$USER/Downloads/progamas

wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget -c https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.21.4_amd64.deb
wget -c https://az764295.vo.msecnd.net/stable/83bd43bc519d15e50c4272c6cf5c1479df196a4d/code_1.60.1-1631294805_amd64.deb

sudo dpkg -i *.deb

## Programas do repositório ##

sudo apt-add-repository ppa:graphics-drivers/ppa  -y
sudo apt-get update
sudo apt install flatpak -y
sudo apt install snapd -y
sudo apt-get update
sudo snap install spotify
sudo snap install skype --classic
sudo snap install photogimp
sudo snap install sublime-text
sudo snap install vlc
sudo snap install onlyoffice-desktopeditors
sudo snap install thunderbird

## instalando gcc ##

sudo apt-get install gcc -y

## install LaTex

sudo apt-get install texlive-full -y
sudo apt-get install texstudio -y

## install Tweak Tools

sudo apt install gnome-tweak-tool gnome-shell-extensions chrome-gnome-shell -y

## install Tor 

sudo apt install torbrowser-launcher -y

sudo apt install htop -y

sudo apt-get autoremove -y


echo "Fim do shellscript"