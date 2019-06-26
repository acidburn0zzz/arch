# Arch Installer

My installation-scripts for *Arch Linux*.
Currently those scripts are just templates for manual installation and are not intended to run on their own.

- **OS:** [Arch Linux](https://www.archlinux.org/)
- **DE:** [suckless-tools](https://suckless.org/philosophy/)
- **Encryption:** LUKS encryption via dm-encrypt/cryptsetup.
An USB-stick with the key needs to be plugged in during bootup in order to decrypt the hard-drive.
- **Bootloader:** systemd-boot
- **Network-Management**: systemd-networkd, systemd-resolved, iwd
- **Power-Management**: systemd-logind, DPMS
- **Time-Syncronization**: systemd-timesyncd

**WARNING: Always make a backup of the key-file and have at least a second USB-Key just in case you lose or break your USB-Key!
Otherwise, you will lock yourself out of your computer.
You will never be able to recover your data!**
