{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-partlabel/NIXROOT";
    fsType = "ext4";
    options = [ "defaults" "discard" "noatime" ];
  };

  fileSystems."/boot/efi" = {
    device = "/dev/disk/by-partlabel/NIXBOOT";
    fsType = "vfat"; # FAT32 is required for UEFI compatibility
    options = [ "defaults" "noatime" ];
  };


  # Swap settings (if needed, adjust to match your system's swap configuration)
  swapDevices = [ ];

  # Enable hardware support
  hardware.enableAllFirmware = true;

  boot.initrd = { 
    supportedFilesystems = [ "vfat" "ext4" "zfs" ];
  };
}
