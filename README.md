# Arch Installer

My installation-scripts for [Arch Linux](https://www.archlinux.org/). This setup stands out because the hard-drive is 256-bit encrypted and can only be decrypted via an USB-Stick which must be plugged in at bootup (no manual typing of the passowrd required). Additionally I try to make use of the [suckless-tools](https://suckless.org/philosophy/) as much as possible ([dwm](https://dwm.suckless.org/), [dmenu](https://tools.suckless.org/dmenu/), [st](https://st.suckless.org/)). My patched and configured versions can be found on my [GitHub-Account](https://github.com/astier). This makes the system very minimal, lightweight, efficient and highly customizable.

- **OS:** Arch Linux
- **Encryption:** LUKS disk-encryption (except boot partition) via dm-encrypt/cryptsetup.
- **Decryption:** Keyfile on an USB-stick which needs to be plugged in during bootup.
- **Bootloader:** systemd-boot
- **DE:** suckless-tools (dwm, dmenu, st)

![screenshot](https://github.com/astier/arch-installer/blob/master/screenshot.png)
