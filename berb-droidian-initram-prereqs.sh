#!/bin/bash

DEB_TARGET_ARCH="$(dpkg-architecture -qDEB_TARGET_ARCH)"
DEB_TARGET_MULTIARCH="$(dpkg-architecture -qDEB_TARGET_MULTIARCH)"

## Install prereqs fom README.md
apt-get install build-essential debootstrap qemu-user-static binfmt-support dpkg-dev

## Install prereqs fom control
apt-get install lsb-release fakeroot dpkg-dev initramfs-tools lxc-android busybox-static coreutils e2fsprogs lvm2 dropbear cryptsetup-initramfs plymouth plymouth-theme-droidian unl0kr droidian-encryption-service pigz tar xkb-data libc6-dev libssl-dev debootstrap lz4 parse-android-dynparts dmsetup

## Innstall the required chroot packages in the host as well
apt-get install initramfs-tools dctrl-tools e2fsprogs libc6-dev zlib1g-dev libssl-dev busybox-static lvm2 cryptsetup xkb-data dropbear pigz liblz4-tool dmeventd yubikey-luks usbutils

## Perl fix from the official Droidian Dockerfile
# sed -i "s|error(g_('diff %s modifies file %s through a symlink: %s')|warning(g_('diff %s modifies file %s through a symlink: %s')|" /usr/share/perl5/Dpkg/Source/Patch.pm
#echo "libdpkg-perl hold" | dpkg --set-selections
