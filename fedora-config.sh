#!/bin/bash

sudo dnf upgrade -y

# Virtualization
sudo dnf group install --with-optional virtualization -y
sudo systemctl start libvirtd
sudo systemctl enable libvirtd

# Packages
sudo dnf install texlive-scheme-medium git -y

# Non-free repos
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# Multimedia Codecs
sudo dnf install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
sudo dnf install lame\* --exclude=lame-devel -y
sudo dnf group upgrade --with-optional Multimedia -y

# Open H264
sudo dnf config-manager --set-enabled fedora-cisco-openh264 -y
sudo dnf install gstreamer1-plugin-openh264 mozilla-openh264 -y

# zsh
cp configs/.zshrc ~/.zshrc
sudo dnf install zsh -y

# Install font for Powerlevel10k
sudo mkdir -p /usr/local/share/fonts/MesloLGS
sudo cp  fonts/* /usr/local/share/fonts/MesloLGS/
sudo chown -R root: /usr/local/share/fonts/MesloLGS
sudo chmod 644 /usr/local/share/fonts/MesloLGS/*
sudo restorecon -vFr /usr/local/share/fonts/MesloLGS
sudo fc-cache -v

# Install Powerlevel10k
cp configs/.p10k.zsh ~/.p10k.zsh
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k

# Configure Konsole
cp configs/konsole/konsolerc ~/.config/konsolerc
cp configs/konsole/zsh.profile ~/.local/share/konsole/zsh.profile
