#!/bin/bash
function calamares {
	git clone https://github.com/wiseos/calamares.git
	cd calamares/pkg
	makepkg -s . && mv *.tar.xz ../.. && cd .. && cd .. && rm -rf && rm -rf wiseos-pkgbuild
}

function download {
	wget https://aur.archlinux.org/cgit/aur.git/snapshot/$1.tar.gz
	tar -xvf $1.tar.gz && cd $1
	#testing delete file
	makepkg -s . && mv *.tar.xz .. && cd .. && rm -rf $1 && rm $1.tar.gz
}

calamares

input="./aur"

#TODO check aur formatting

while IFS= read -r line
do	
	echo "$line"	
	if [ -n "${line}" ]; then	
		download "$line"
	fi
done < "$input"

echo "####################################"
echo "Repo Downloaded!!"
echo "####################################"
