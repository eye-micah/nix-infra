{ config, envVars, pkgs, ... }:

{
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.package = pkgs.zfs_unstable;

  systemd.services.zfs-import = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
    description = "ZFS Pool Import";
    serviceConfig = {
      ExecStart = "${pkgs.zfs}/bin/zpool import ${envVars.zfsSolidStatePool}";
      ExecStop = "${pkgs.zfs}/bin/zpool export ${envVars.zfsSolidStatePool}";
    };
  };

  # Define the zfs-scrub service
  systemd.services.zfs-scrub = {
    description = "ZFS Pool Scrub";
    serviceConfig = {
      ExecStart = "${pkgs.zfs}/bin/zpool scrub ${envVars.zfsSolidStatePool}";
    };
  };

  # Define the zfs-scrub timer
  systemd.timers.zfs-scrub = {
    description = "ZFS Pool Scrub Timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly"; # Set the desired schedule
    };
  };

  # Define the zfs-trim service
  systemd.services.zfs-trim = {
    description = "ZFS Pool Trim";
    serviceConfig = {
      ExecStart = "${pkgs.zfs}/bin/zpool trim ${envVars.zfsSolidStatePool}";
    };
  };

  # Define the zfs-trim timer
  systemd.timers.zfs-trim = {
    description = "ZFS Pool Trim Timer";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly"; # Set the desired schedule
    };
  };

  environment.systemPackages = with pkgs; [
    zfs
  ];
}
