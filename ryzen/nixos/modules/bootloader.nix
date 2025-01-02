{ config, lib, pkgs, ... }:
{
  # Bootloader configuration for UEFI only
  boot.loader.grub = {
    enable = true;
    version = 2;
    efiSupport = true;
    devices = [ "nodev" ]; # No specific device needed for UEFI
    enableCryptodisk = false; # Set to true if using encrypted disks
    efiInstallAsRemovable = true; # Ensures compatibility with systems requiring removable media boot
  };

  # Ensure the EFI system partition is properly mounted
  fileSystems."/boot/efi" = {
    device = "LABEL=NIXBOOT"; # Replace with the actual label of your EFI partition
    fsType = "vfat";
  };

  # Kernel parameters for boot customization
  boot.kernelParams = [ "loglevel=4" "quiet" ];

  # System fails if not booted via UEFI
  assertions = [
    { assertion = builtins.pathExists "/sys/firmware/efi";
      message = "This system requires UEFI firmware to boot.";
    }
  ];
}
