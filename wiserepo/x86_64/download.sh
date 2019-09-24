#!/bin/bash
function calamares {
	git clone https://github.com/wiseos/wiseos-pkgbuild.git
	cd wiseos-pkgbuild/calamares-git 
	makepkg -s . && mv *.tar.xz ../.. && cd .. && cd .. && rm -rf && rm -rf wiseos-pkgbuild
}

function download {
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz
	tar -xvf $1.tar.gz && cd $1
	makepkg -s . && mv *.tar.xz .. && cd .. && rm -rf $1 && rm $1.tar.gz
}

#TODO need optimization with un loop from file
calamares

download cava
download yay
download polybar
download shantz-xwinwrap-bzr
download ckbcomp
download betterlockscreen 
download mkinitcpio-openswap
download gotop
download curseradio-git
download ttf-weather-icons
download nerd-fonts-hack
download nerd-fonts-iosevka
download wpa_actiond


echo "####################################"
echo "Repo Downloaded!!"
echo "####################################"
