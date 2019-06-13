# Arch Installer

My installation-scripts for [Arch Linux](https://www.archlinux.org/). Currently those scripts are just templates for manual installation and are not intended to run on their own. This setup may be interesting for some people because of the following reasons:

- **OS:** [Arch Linux](https://www.archlinux.org/)
- **Bootloader:** systemd-boot
- **DE:** Cinnamon
- **Encryption:** LUKS encryption of the root-partition via dm-encrypt/cryptsetup. For decryption an USB-stick with the key needs to be plugged in during bootup.

## Encryption

**WARNING: Always make a backup of the key-file and have at least a second USB-Key just in case you lose or break your USB-Key! Otherwise, you will lock yourself out of your computer. You will never be able to recover your data!**

The hard-drive can only be decrypted via an USB-Stick which must be plugged in at bootup. This is handy not only because it protects your data from thief's, snoopy repairmen and all other people who have access to your computer, but also because no manual typing of the password at bootup is required. The hard-drive gets automatically encrypted as long as the key is plugged in. This enables you to use a very strong password which you do not have to remember. The password can be any file, even images. Combined with auto-login starting your machine becomes a bliss.
