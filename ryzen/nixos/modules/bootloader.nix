{ config, lib, pkgs, ... }:
let
  isUEFI = builtins.pathExists "/sys/firmware/efi";
in
{
  # Bootloader configuration for Legacy and UEFI
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = isUEFI;
    devices = if isUEFI then [ "nodev" ] else [ "LABEL=NIXBOOT" ];
    enableCryptodisk = false; # or make configurable
  };
  # Kernel parameters
  boot.kernelParams = [ "loglevel=4" "quiet" ];
}

