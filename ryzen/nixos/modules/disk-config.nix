{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            efi = {
              start = "0";
              size = "512MiB";
              type = "efi";
              format = "vfat";
              mountPoint = "/boot/efi";
            };
            root = {
              start = "512MiB";
              type = "primary";
              format = "ext4";
              mountPoint = "/";
            };
          };
        };
      };
    };
  };
}
