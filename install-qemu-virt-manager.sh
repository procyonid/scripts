#!/bin/sh

# first argument = username

pacman -S qemu libvirt virt-manager
systemctl enable libvirtd.service
usermod -aG libvirt $1

echo "Reboot required for virtual networks"
