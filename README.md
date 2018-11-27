# Arch Installer
My installation-scripts for *Arch Linux + Xfce + LUKS (USB-Keyfile-Decryption) + systemd-boot*. Currently the scripts are not supposed to actually run but serve as templates for future manual installations.
- **OS:** Arch Linux
- **Bootloader:** systemd-boot
- **DE:** Xfce
- **Encryption:** LUKS disk-encryption (except boot partition) via dm-encrypt/cryptsetup.
- **Decryption:** Keyfile on an USB-stick which needs to be plugged in to decrypt the disk. No manual typing of the password required.

![alt text](https://github.com/astier/arch-installer/blob/master/Screenshot_2018-11-26_02-08-20.png)
