{
  disko.devices = {
    disk = {
      type = "disk";
      device = "/dev/sda";
      content = {
        type = "gpt";
        partitions = {
          efi = {
            start = "0";
            size = "512MiB";
            type = "efi";
            content = {
              type = "filesystem";
              format = "vfat";
              mountPoint = "/boot/efi";
            };
          };
          root = {
            start = "512MiB";
            type = "primary";
            content = {
              type = "filesystem";
              format = "ext4";
              mountPoint = "/";
            };
          };
        };
      };
    };
  };
}
