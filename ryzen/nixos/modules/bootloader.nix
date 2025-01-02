{ config, lib, pkgs, ... }:
{
  # Bootloader configuration for systemd-boot (UEFI only)
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # EFI system partition mount point
    };
  };

  # Ensure the EFI system partition is properly mounted
  fileSystems."/boot/efi" = {
    device = "LABEL=NIXBOOT"; # Replace with the actual label of your EFI partition
    fsType = "vfat";
  };

  # Kernel parameters for boot customization
  boot.kernelParams = [ "loglevel=4" "quiet" ];

}

