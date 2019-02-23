# Arch Installer

My installation-scripts for (Arch Linux)[https://www.archlinux.org/]. This setup stands out because the drive is 256-bit encrypted and can only be decrypted via an USB-Stick which must be plugged in at bootup. Additionally I try to make use of the (suckless-tools)[https://suckless.org/] as much as possible ((dwm)[https://dwm.suckless.org/], (dmenu)[https://tools.suckless.org/dmenu/], (st)[https://st.suckless.org/]). My patched and configured versions can be found on my (GitHub-Account)[https://github.com/astier]. This results in a very minimal and lightweight system.

- **OS:** Arch Linux
- **Encryption:** LUKS disk-encryption (except boot partition) via dm-encrypt/cryptsetup.
- **Decryption:** Keyfile on an USB-stick which needs to be plugged in during bootup. No manual typing of the password required.
- **Bootloader:** systemd-boot
- **DE:** (dwm)[https://dwm.suckless.org/]
- **Terminal**: (st)[https://st.suckless.org/]
