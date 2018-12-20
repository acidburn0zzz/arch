# Arch Installer

My installation-scripts for *Arch Linux + Cinnamon + LUKS (USB-Keyfile-Decryption) + systemd-boot*. Currently the scripts are not supposed to actually run but serve as templates for future manual installations.

- **OS:** Arch Linux
- **Encryption:** LUKS disk-encryption (except boot partition) via dm-encrypt/cryptsetup.
- **Decryption:** Keyfile on an USB-stick which needs to be plugged in during bootup. No manual typing of the password required.
- **Bootloader:** systemd-boot
- **DE:** Cinnamon
