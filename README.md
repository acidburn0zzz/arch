# Arch Installer

My installation-scripts for [Arch Linux](https://www.archlinux.org/). Currently those scripts are just templates for manual installation and are not intended to run on their own. This setup may be interesting for some people because of the following reasons:

- **OS:** [Arch Linux](https://www.archlinux.org/)
- **DE:** [suckless-tools](https://suckless.org/philosophy/) ([dwm](https://dwm.suckless.org/), [slock](https://tools.suckless.org/slock/), [st](https://st.suckless.org/))
- **Encryption:** LUKS encryption of the root-partition via dm-encrypt/cryptsetup. For decryption an USB-stick with the key has to be plugged in during bootup.
- **Bootloader:** systemd-boot
- **Network-Management**: systemd-networkd, systemd-resolved, iwd (much better than wpa_supplicant)
- **Power-Management**: systemd-logind, DPMS
- **Time-Syncronization**: systemd-timesyncd

## Encryption

**WARNING: Always make a backup of the key-file and have at least a second USB-Key just in case you lose or break your USB-Key! Otherwise, you will lock yourself out of your computer. You will never be able to recover your data!**

The hard-drive is 256-bit encrypted and can only be decrypted via an USB-Stick which must be plugged in at bootup. This is handy not only because it protects your data from thief's, snoopy repairmen (in case you give your computer away for repair) and all other people who have access to your computer, but also because no manual typing of the password at bootup is required. The hard-drive gets automatically encrypted as long as the key is plugged in. This enables you to use a very strong password which you do not have to remember. Combined with auto-login starting your machine becomes a bliss.

## Systemd

I try to use systemd as much as possible. Although, some people don't like systemd and see it as a security-risk and bloat, my philosophy is that since I am already using it because of Arch I might as well use its full potential to avoid adding additional dependencies to solve tasks which systemd already can solve. This includes the bootloader, power-management, network-management and time-synchronisation.

## Suckless

I try to use the [suckless-tools](https://suckless.org/philosophy/) as much as possible ([dwm](https://dwm.suckless.org/), [slock](https://tools.suckless.org/slock/), [st](https://st.suckless.org/)). This makes the system very minimal, lightweight, efficient and highly customizable. Because of the minimal code-base of the suckless-tools, understanding and hacking them becomes rather easy.
