#!/bin/bash

set -e -u
umask 022

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
#sed -i 's/#\(it_IT\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf
# virtual console
#echo "KEYMAP=it" > /etc/vconsole.conf

ln -sf /usr/share/zoneinfo/UTC /etc/localtime
hwclock --systohc --utc
#set root
usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 750 /root #apricity 700

chown -R root /etc/sudoers.d
chmod -R 755 /etc/sudoers.d
#enable autologin
#groupadd -r autologin
#gpasswd -a root autologin

#groupadd -r nopasswdlogin
#gpasswd -a root nopasswdlogin
#********************************
# add liveuser
useradd -m liveuser -u 500 -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/zsh
chown -R liveuser:users /home/liveuser

#enable autologin
groupadd -r autologin
gpasswd -a liveuser autologin

groupadd -r nopasswdlogin
gpasswd -a liveuser nopasswdlogin

#autorun calamares
mkdir -p /home/liveuser/.config/autostart
ln -s /usr/share/applications/calamares-wiseOS.desktop /home/liveuser/.config/autostart/calamares.desktop
chmod +rx /home/liveuser/.config/autostart/calamares.desktop
chown liveuser /home/liveuser/.config/autostart/calamares.desktop

###
#mkdir -p /home/liveuser/.config/autostart
#ln -fs /usr/share/applications/calamares.desktop /home/liveuser/.config/autostart/calamares.desktop


sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

#Services
systemctl enable pacman-init.service choose-mirror.service
systemctl enable lightdm.service
systemctl enable NetworkManager.service
#systemctl enable org.cups.cupsd.service
systemctl enable avahi-daemon.service
#systemctl enable ntpd.service
#systemctl enable bluetooth.service
systemctl set-default graphical.target

#systemctl set-default multi-user.target
rm -fr /etc/pacman.d/gnupg

pacman-key --init 
pacman-key --populate archlinux 
pacman-key --populate wiseos
pacman-key --lsign-key 3E9F489D3AFBA5C475FE68522544653118820C07

pacman -Scc --noconfirm
pacman -Syyu --noconfirm
