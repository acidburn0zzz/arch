# Arch Installer

My installation-scripts for [Arch Linux](https://www.archlinux.org/). Currently those scripts are just templates for manual installation and are not intended to run on their own. This setup may be interesting for some people because of the following reasons:

- **OS:** Arch Linux
- **DE:** suckless-tools (dwm, dmenu, st)
- **Encryption:** LUKS encryption of the root-partition via dm-encrypt/cryptsetup. For decryption an USB-stick with the key needs to be plugged in during bootup.
- **Bootloader:** systemd-boot
- **Network-Management**: systemd-networkd, systemd-resolved + iwd (much better than wpa_supplicant)
- **Power-Management**: systemd-logind
- **Time-Syncronization**: systemd-timesyncd

## Encryption

The hard-drive is 256-bit encrypted and can only be decrypted via an USB-Stick which must be plugged in at bootup. This is handy not only because it protects your data from thief's and snoopy repairmen (in case you give your computer away for repair) but also because no manual typing of the password at bootup is required. The hard-drive gets automatically encrypted as long as the key is plugged in. Combined with auto-login starting your machine becomes a bliss.

## Suckless

I try to make use of the [suckless-tools](https://suckless.org/philosophy/) as much as possible ([dwm](https://dwm.suckless.org/), [dmenu](https://tools.suckless.org/dmenu/), [st](https://st.suckless.org/)). This makes the system very minimal, lightweight, efficient and highly customizable.

## Systemd
I try to make us of systemd as much as possible. Although, some people don't like systemd and see it as a security-risk and bloat my philosophy is that since I am already using it because of Arch I might as well use its full potential to avoid adding additional dependencies to solve tasks which systemd already can solve. This includes the bootloader, power-management, network-management and time-synchronisation.

## Screenshots

![screenshot](https://github.com/astier/arch-installer/blob/master/screenshot.png)
