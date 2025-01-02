{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    disko
  ];

  disko = {
      # Define the disk layout for partitioning
      disks = {
        "/dev/sda" = {
          # EFI partition
          partitions = {
            "EFI" = {
              mountPoint = "/boot/efi";
              size = "512M";
              fsType = "vfat";
              label = "NIXBOOT";  # Label the partition
              bootable = true;
            };

            # Root partition
            "root" = {
              mountPoint = "/";
              size = "100%";  # Use the remaining space after the EFI partition
              fsType = "ext4";
              label = "NIXROOT";  # Label the partition
            };
          };
        };
      };
  };
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

  # Ensure the EFI system partition is mounted correctly
  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-partlabel/NIXBOOT";  # Replace with the actual label of your EFI partition
    fsType = "vfat";  # UEFI system partition is usually formatted as vfat
    options = [ "defaults" "noatime" ];
  };

  # Filesystem configuration for root partition
  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/NIXROOT";
    fsType = "ext4";
    options = [ "defaults" "discard" "noatime" ];
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
