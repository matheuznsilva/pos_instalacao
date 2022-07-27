#!/bin/bash

set -e

## DEFINE URL's
GOOGLE_CHROME = https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
TEAM_VIEWER = https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.21.4_amd64.deb
CEREBRO = https://github.com/cerebroapp/cerebro/releases/download/v0.5.0/cerebro_0.5.0_amd64.deb ##-O cerebro.deb 
PULSE_EFFECTS = https://launchpadlibrarian.net/319770251/pulseeffects_1.313entornosgnulinuxenial-1ubuntu1_amd64.deb

APT_PROGRAMS = (
    ubuntu-restricted-extras
    gcc
    make
    snapd
    htop
    flatpak
    curl
    stacer
    torbrowser-launcher
    gnome-tweak-tool 
    gnome-shell-extensions chrome-gnome-shell
    texlive-full
    texstudio
)

SNAP_PROGRAMS = (
    ##penjdk-17-jre-headless
    code --classic
    flutter --classic
    sublime-text --classic
    android-studio --classic
    brackets --classic
    gnome-calendar
    thunderbird
    onlyoffice-desktopeditors
    telegram-desktop
    spotify
    photogimp
    vlc
)

## DIRECTORIES
DIRECTORY_DOWNLOADS = "~/Downloads/programs"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"

#COLORS
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


# ============================= FUNCTIONS ============================== #

## UPDATE FUNCTION
apt_update(){
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y
}

## CONNECTION TEST
connection_test(){
    if [! ping -c 1 8.8.8.8 -q &> /dev/null]; then
        echo -e "${VERMELHO}[ERROR] - YOU HAVEN'T INTERNET CONNECTION.${SEM_COR}"
        exit 1
    else
        echo -e "${VERDE}[INFO] - INTERNET CONNECTION SUCCESSFULLY ESTABLISHED.${SEM_COR}"
    fi
}

## REMOVE LOCKS APT
remove_locks(){
    sudo rm/var/lib/dpkg/lock-frontend && sudo rm/var/cache/apt/archives/lock
}

## INSTALL PROGRAMS .DEB, APT && SNAP
install_programs(){
    echo -e "${VERDE}[INFO] - DOWNLOADING PACKAGES .deb${SEM_COR}"

    mkdir "$DIRECTORY_DOWNLOADS"
    wget -c "$GOOGLE_CHROME"       -P "$DIRECTORY_DOWNLOADS"   
    wget -c "$TEAM_VIEWER"       -P "$DIRECTORY_DOWNLOADS" 
    wget -c "$CEREBRO"       -P "$DIRECTORY_DOWNLOADS" 
    # wget -c "$PULSE_EFFECTS"       -P "$DIRECTORY_DOWNLOADS" 

    ## INSTALL PACKAGES .deb
    echo -e "${VERDE}[INFO] - INSTALL PACKAGES .deb${SEM_COR}"
    sudo apt --fix-broken install -y
    sudo dpkg -i $DIRECTORY_DOWNLOADS/*.deb

    ## INSTALL PACKAGES APT 
    echo -e "${VERDE}[INFO] - INSTALL PACKAGES APT FROM REPOSITORY${SEM_COR}"
    for program in ${APT_PROGRAMS[@]}; do
        if [! dpkg -l | grep -q $program]; then # Only install if not already installed
            sudo apt install "$program" -y
        else
            echo "$program - [INSTALLED]"
        fi
    done

    ## INSTALL PACKAGES SNAP 
    echo -e "${VERDE}[INFO] - INSTALL PACKAGES APT FROM REPOSITORY${SEM_COR}"
    for program in ${SNAP_PROGRAMS[@]}; do
        if [! dpkg -l | grep -q $program]; then # Only install if not already installed
            sudo snap install "$program" -y
        else
            echo "$program - [INSTALLED]"
        fi
    done
}

## INSTALL FLATPAK PROGRAMS
install_flatpaks(){

    echo -e "${VERDE}[INFO] - INSTALL FLATPACK PACKAGES${SEM_COR}"
    flatpak install --user https://flathub.org/repo/appstream/io.github.mmstick.FontFinder.flatpakref -y
    flatpak --user update io.github.mmstick.FontFinder -y
}

## ADDING REPOSITORY
adding_repository(){
    ##sudo add-apt-repository ppa:nilarimogard/webupd8 -y && sudo apt-get update && sudo apt-get install pulseaudio-equalizer -y
    sudo apt-add-repository ppa:graphics-drivers/ppa -y && sudo apt install nvidia-driver-470 -y
}


# ======================= FINISHING INSTALLATION ======================= #
system_clean(){
    sudo apt-get update && sudo apt-get upgrade -y && sudo apt full-upgrade -y
    flatpak update
    sudo apt autoclean -y
    sudo apt autoremove -y
    sudo reboot
}

# ============================== EXECUTION ============================= #

remove_locks
connection_test
remove_locks
adding_repository
apt_update
remove_locks
install_programs
install_flatpaks
apt_update
system_clean

echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"