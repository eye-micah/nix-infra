{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Filesystem configuration
  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXROOT";
    fsType = "ext4";
    options = [ "defaults" "discard" "noatime" ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/NIXBOOT";
    fsType = "vfat"; # FAT32 is required for UEFI compatibility
    options = [ "defaults" "noatime" ];
  };


  # Swap settings (if needed, adjust to match your system's swap configuration)
  swapDevices = [ ];

  # Enable hardware support
  hardware.enableAllFirmware = true;
}
