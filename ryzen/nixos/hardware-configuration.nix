{ config, lib, pkgs, ... }:

{
  imports = [ ];

  # Filesystem configuration
  fileSystems."/" = {
    device = "UUID=327c54d8-b2d9-4378-85d7-8ddc4d63da91";
    fsType = "ext4";
    options = [ "defaults" "discard" "noatime" ];
  };

  fileSystems."/boot/efi" = {
    device = "UUID=12CE-A600";
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
