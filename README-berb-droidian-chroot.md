# initram droidian next-101-20250729-arm64 luks skel
This skel is the uses the official Droidian initram, updated to 20250729, and adds support for using Yubikeys at the initram boot time.

The process requires building an initram using the initramfs-tools-halium. It allows to add additional  packages and hooks. In this case, yubykey and usbutils.

I'm using a Droidian device to make the build, but the proces not works 100% for me. The generated image contains all the files installed by the hooks, but not all the base binaries. The image is 10M smallest.

As temporal solution, i'm using a partially initram image generated with the yubikey hooks, and then merge the required new files into an extracted official build.

After making some changes to the official build script (chroot mode), published in the branch berb-chroot-yubikey from the https://github.com/berbascum/initramfs-tools-halium, i can run the build-initrd.sh script and get the partial initram image.
But previously, the berb-droidian-initram-prereqs.sh can be used to install the full prereqs.

## Steps: to reproduce
1- Extract the official initram on a tmp dir
2- Create a git repo in the dir, add all and commit as initial.
3- Extract the generated initram with luks support into the first directori.
4- Clean the non required files:
> rm scripts/local-bottom/yubikey-luks scripts/local-top/yubikey-luks 
> git restore  etc/ld.so.cache etc/passwd scripts/local-bottom/ORDER scripts/local-top/ORDER
> git restore etc/dropbear/dropbear_dss_host_key etc/dropbear/dropbear_ecdsa_host_key etc/dropbear/dropbear_rsa_host_key
> rm etc/dropbear/dropbear_dss_host_key etc/dropbear/dropbear_ecdsa_host_key etc/dropbear/dropbear_rsa_host_key
> git add etc/dropbear/dropbear_dss_host_key etc/dropbear/dropbear_ecdsa_host_key etc/dropbear/dropbear_rsa_host_key
5- Commit the removed keys.
6- Remove the new root-* dir created.
7- Repack again the image using cpio

## Cleaned list of files added:
etc/ykluks.cfg
lib/aarch64-linux-gnu/libjson-c.so.3
lib/aarch64-linux-gnu/libjson-c.so.3.0.1
lib/aarch64-linux-gnu/libusb-1.0.so.0
lib/aarch64-linux-gnu/libusb-1.0.so.0.1.0
sbin/ykluks-keyscript
usr/bin/ykchalresp
usr/lib/aarch64-linux-gnu/libykpers-1.so.1
usr/lib/aarch64-linux-gnu/libykpers-1.so.1.17.3
usr/lib/aarch64-linux-gnu/libyubikey.so.0
usr/lib/aarch64-linux-gnu/libyubikey.so.0.1.7
usr/lib/udev/hwdb.d/20-libgphoto2-6t64.hwdb
usr/lib/udev/hwdb.d/20-sane.hwdb
usr/lib/udev/hwdb.d/60-upower-battery.hwdb
usr/lib/udev/hwdb.d/61-gmobile-wakeup.hwdb
usr/lib/udev/hwdb.d/69-libmtp.hwdb
usr/lib/udev/hwdb.d/95-upower-hid.hwdb
