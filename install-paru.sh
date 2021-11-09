#!/usr/bin/env bash

if (( $EUID != 0 )); then
	echo "This script must not be run as root (because of makepkg)"
	exit 1
fi

sudo pacman -S --needed base-devel

FOLDER="$(mktemp -d)"
git clone https://aur.archlinux.org/paru.git $FOLDER
cd $FOLDER
makepkg -si
cd ..
rm -rf $FOLDER
