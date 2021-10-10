
# My Archlinux System 
# https://zhuanlan.zhihu.com/p/384377987


# Make Sure time is currect
timedatectl set-ntp true

genfstab -U /mnt > /mnt/etc/fstab


# Install System

pacstrap /mnt base linux linux-firmware zsh wget curl axel htop tree ntfs-3g exfat-utils zip unzip rar unrar p7zip tcpdump nmap grub

pacstrap /mnt zsh zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-lovers zsh-syntax-highlighting

pacstrap /mnt thunderbird thunderbird-i18n-en-us thunderbird-i18n-zh-cn


# editors
pacstrap /mnt vim nano texlive-core texlive-langchinese

# man
pacstrap /mnt man-db man-pages texinfo

# nettools
pacstrap /mnt iproute2 

# devel language
pacstrap /mnt go python python-pip nodejs npm rust gcc gdb 

# devel tools
pacstrap /mnt ctags tmux make cmake git docker docker-compose kubectl vscode firefox gdb-dashboard clang llvm privoxy

pacstrap /mnt xorg xorg-drivers xorg-xinit xorg-xrandr xorg-twm xterm

# GUI
pacstrap /mnt gdm gnome gnome-extra qt5 fcitx fcitx-configtool fcitx-qt4 fcitx-qt5 fcitx-gtk2 fcitx-gtk3 fcitx-sogoupinyin powerline powerline-fonts wqy-zenhei wqy-microhei wqy-bitmapfont tor

arch-chroot /mnt
Xorg :0 -configure
mv /root/xorg.conf.new /etc/X11/xorg.conf

systemctl enable gdm

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

hwclock --systohc
cat <<EOF> /etc/locale.gen
en_US ISO-8859-1
en_US.UTF-8 UTF-8
zh_CN.GBK GBK
zh_CN.UTF-8 UTF-8
EOF

locale-gen
cat <<EOF> /etc/locale.conf
LANG=zh_CN.UTF-8
LC_NUMERIC=en_US.UTF-8
LC_TIME=en_US.UTF-8
LC_COLLATE=en_US.UTF-8
LC_MONETARY=en_US.UTF-8
LC_MESSAGES=en_US.UTF-8
LC_PAPER=en_US.UTF-8
LC_NAME=en_US.UTF-8
LC_ADDRESS=en_US.UTF-8
LC_TELEPHONE=en_US.UTF-8
LC_MEASUREMENT=en_US.UTF-8
LC_IDENTIFICATION=en_US.UTF-8
LC_CTYPE=zh_CN.UTF-8
LC_ALL="C"
LANGUAGE=zh_CN.UTF-8
EOF

echo "PC" > /etc/hostname

echo "Please see the last commands in this file, clean command `grep -A100 exit archlinux.sh`"
exit

passwd
# Xorg
## Video Driver
pacman -S xf86-video-amdgpu mesa lib32-mesa # AMD, OpenGL, OpenGL (multilib)
pacman -S xf86-video-ati mesa lib32-mesa # ATI, OpenGL, OpenGL (multilib)
pacman -S xf86-video-intel mesa lib32-mesa # Intel, OpenGL, OpenGL (multilib)
pacman -S xf86-video-nouveau mesa lib32-mesa # NVIDIA OpenSource, OpenGL, OpenGL (multilib)
pacman -S nvidia nvidia-utils lib32-nvidia-utils # NVIDIA Proprietary, OpenGL, OpenGL (multilib)
pacman -S nvidia-390xx nvidia-390xx-utils lib32-nvidia-390xx-utils # NVIDIA Proprietary AUR, OpenGL, OpenGL (multilib)
## Hardware Video acceleration
## https://wiki.archlinux.org/title/Hardware_video_acceleration_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)


# https://wiki.archlinux.org/title/GRUB_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87)
# if `ls /sys/firmware/efi/efivars`(before arch-chroot!!!) have files, it must install `efibootmgr`
# and `grub-install` will be `grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB`
# https://zhuanlan.zhihu.com/p/384377987
grub-install /dev/sdX
grub-mkconfig -o /boot/grub/grub.cfg

