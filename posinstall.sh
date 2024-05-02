#!/bin/bash

set -e

## DEFINE URL's
GOOGLE_CHROME=https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
TEAM_VIEWER=https://dl.teamviewer.com/download/linux/version_15x/teamviewer_15.21.4_amd64.deb
# CEREBRO=https://github.com/cerebroapp/cerebro/releases/download/v0.5.0/cerebro_0.5.0_amd64.deb
POSTMAN=https://dl.pstmn.io/download/latest/linux_64

APT_PROGRAMS=(
    ubuntu-restricted-extras
    gcc
    git
    curl
    flatpak
    libminizip1
    libxcb-xinerama0
    -f    
    gnome-shell-extensions chrome-gnome-shell
   #gnome-tweaks
    htop
    libfuse2
    make
    mysql-server
    net-tools
    python3
    python3-pip
    snapd
    stacer
    texlive-full
    texstudio
    torbrowser-launcher
    virtualbox
    virtualbox-ext-pack
)

SNAP_PROGRAMS=(
    ##penjdk-17-jre-headless
    android-studio --classic
    code
    figma-linux
    flutter
    gnome-calendar
    mysql-workbench-community
    onlyoffice-desktopeditors
    photogimp
    spotify
    #sublime-text
    #telegram-desktop
    thunderbird
    vlc
)

FLATPAK_PROGRAMS=(
    "https://flathub.org/repo/appstream/io.github.mmstick.FontFinder.flatpakref"
    "https://flathub.org/repo/appstream/com.github.wwmm.easyeffects.flatpakref"
)

## DIRECTORIES
DIRECTORY_DOWNLOADS="$HOME/Downloads/programs"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"

#COLORS
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'


# ============================= FUNCTIONS ============================== #

## UPDATE FUNCTION
apt_update(){
    sudo apt update && sudo apt full-upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
}

## CONNECTION TEST
connection_test(){
    if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
        echo -e "${VERMELHO}[ERROR] - YOU HAVEN'T INTERNET CONNECTION.${SEM_COR}"
        exit 1
    else
        echo -e "${VERDE}[INFO] - INTERNET CONNECTION SUCCESSFULLY ESTABLISHED.${SEM_COR}"
    fi
}

## REMOVE LOCKS APT
remove_locks(){
    if sudo rm /var/lib/dpkg/lock-frontend; then
        echo -e "${VERDE}[INFO] - Removed lock file: /var/lib/dpkg/lock-frontend${SEM_COR}"
    else
        echo -e "${VERMELHO}[ERROR] - Failed to remove lock file: /var/lib/dpkg/lock-frontend${SEM_COR}"
    fi
    
    if sudo rm /var/cache/apt/archives/lock; then
        echo -e "${VERDE}[INFO] - Removed lock file: /var/cache/apt/archives/lock${SEM_COR}"
    else
        echo -e "${VERMELHO}[ERROR] - Failed to remove lock file: /var/cache/apt/archives/lock${SEM_COR}"
    fi
}

## ADDING/CONFIRMING X86 ARCHITECTURE
add_archi386(){
    sudo dpkg --add-architecture i386
}

## INSTALL APT PACKAGES 
install_APT_Packages(){
    echo -e "${VERDE}[INFO] - INSTALL PACKAGES APT FROM REPOSITORY${SEM_COR}"
    for program in "${APT_PROGRAMS[@]}"; do
        if ! dpkg -l "$program" &> /dev/null; then # Only install if not already installed
            sudo apt install "$program" -y
            sudo apt --fix-broken install -y
        else
            echo "$program - [INSTALLED]"
        fi
    done
}

## INSTALL SNAP PACKAGES 
install_SNAP_Packages(){
    echo -e "${VERDE}[INFO] - INSTALL PACKAGES SNAP FROM REPOSITORY${SEM_COR}"
    for program in "${SNAP_PROGRAMS[@]}"; do
        if ! snap list "$program" &> /dev/null; then # Only install if not already installed
            sudo snap install --classic "$program"
        else
            echo "$program - [INSTALLED]"
        fi
    done
}

## INSTALL DEB PACKAGES 
install_DEB_Packages(){
    echo -e "${VERDE}[INFO] - DOWNLOADING PACKAGES .deb${SEM_COR}"
    mkdir "$DIRECTORY_DOWNLOADS" || true
    wget -c "$GOOGLE_CHROME" "$TEAM_VIEWER" -P "$DIRECTORY_DOWNLOADS"

    ## INSTALL .deb PACKAGES
    echo -e "${VERDE}[INFO] - INSTALL PACKAGES .deb${SEM_COR}"
    sudo apt --fix-broken install -y
    sudo dpkg -i $DIRECTORY_DOWNLOADS/*.deb 

    ## REMOVE INSTALLERS AND DIRECTORY
    echo -e "${VERDE}[INFO] - REMOVING INSTALLERS AND DIRECTORY${SEM_COR}"
    rm -rf "$DIRECTORY_DOWNLOADS"
}

## INSTALL FLATPAK PROGRAMS

install_Flatpaks(){
    echo -e "${VERDE}[INFO] - INSTALL FLATPAK PACKAGES${SEM_COR}"
  
    for ref in "${FLATPAK_PROGRAMS[@]}"; do
        flatpak install --user "$ref" -y
        flatpak --user update "$(basename "$ref" .flatpakref)" -y
    done
}

## INSTALL PROGRAMS .deb, APT, SNAP and Flatpaks
install_programs(){
    install_APT_Packages
    install_SNAP_Packages
    install_DEB_Packages
    install_Flatpaks
}

## ADDING REPOSITORY
adding_repository(){
    sudo apt-add-repository ppa:graphics-drivers/ppa -y && sudo apt install nvidia-driver-470 -y
    sudo apt-add-repository universe -y
}

# ============================== EXECUTION ============================= #

remove_locks
connection_test
apt_update
adding_repository
add_archi386
apt_update
install_programs
apt_update
remove_locks
sudo reboot

echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"