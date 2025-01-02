{ config, lib, pkgs, ... }:

{
  # Bootloader configuration for GRUB (UEFI only)
  boot.loader = {
    grub = {
      enable = true;
      version = 2;  # Use GRUB 2
      efiSupport = true;  # Enable UEFI support
      efiInstallAsRemovable = false;  # Optional: Can be true if installing in a removable EFI partition
      device = "sda";  # Use the appropriate disk for UEFI boot (usually the main disk)
    };

    # EFI system partition setup
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";  # Mount point for the EFI system partition
    };
  };

  # Ensure the EFI system partition is mounted correctly
  fileSystems."/boot/efi" = {
    device = "UUID=12CE-A600";  # Replace with the actual label of your EFI partition
    fsType = "vfat";  # UEFI system partition is usually formatted as vfat
  };

  # Kernel parameters for boot customization
  boot.kernelParams = [ "loglevel=4" "quiet" ];
}


