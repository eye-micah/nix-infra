{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    disko
  ];

  # Bootloader configuration for GRUB (UEFI only)
  boot.loader = {
    grub = {
      enable = true;
      version = 2;  # Use GRUB 2
      efiSupport = true;  # Enable UEFI support
      efiInstallAsRemovable = false;  # Optional: Can be true if installing in a removable EFI partition
      device = "nodev";  # Use the appropriate disk for UEFI boot (usually the main disk)
    };

    # EFI system partition setup
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";  # Mount point for the EFI system partition
    };
  };

  # Swap settings (if needed, adjust to match your system's swap configuration)
  swapDevices = [ ];

  # Enable hardware support
  hardware.enableAllFirmware = true;

  # Kernel parameters for boot customization
  boot.kernelParams = [ "loglevel=4" "quiet" ];

  # Initrd configuration for supported filesystems
  boot.initrd = {
    supportedFilesystems = [ "vfat" "ext4" "zfs" ];  # Add any filesystems you need here
  };
}
