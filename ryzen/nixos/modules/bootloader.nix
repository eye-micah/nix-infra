{ config, lib, pkgs, ... }:

{
  # Bootloader configuration for Legacy and UEFI
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = config.boot.isUEFI;
    devices = if config.boot.isUEFI then [ "nodev" ] else [ "/dev/sda" ];
    enableCryptodisk = false; # or make configurable
  };

  # Kernel parameters
  boot.kernelParams = [ "loglevel=4" "quiet" ];
}

