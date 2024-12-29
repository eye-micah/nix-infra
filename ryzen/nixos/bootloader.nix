{ config, lib, pkgs, ... }:

{
  # Bootloader configuration for Legacy and UEFI
  boot.loader = {
    grub = {
      enable = true;
      version = 2;
      efiSupport = true;
      devices = [ "nodev" ];
      enableCryptodisk = false;
    };

    efi = {
      canTouchEfiVariables = true;
    };
  };

  # Kernel parameters
  boot.kernelParams = [ "loglevel=4" "quiet" ];
}

