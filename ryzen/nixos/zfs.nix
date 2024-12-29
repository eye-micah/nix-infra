# Basic ZFS module. Goal is to be nondestructive and simply import existing pools.

{ config, envVars, pkgs, ... }:

{

    boot.supportedFilesystems = [ "zfs" ];
    boot.zfs.enableUnstable = true;
    boot.zfs.forceImport = true;

    services.zfs.enable = true;

    systemd.timers.zfs-scrub = {
        enable = true;
        # Set the frequency of the scrub (e.g., once a month)
        timerConfig = {
        OnCalendar = "weekly";  # Or use "weekly", "daily", etc.
        };
        serviceConfig.ExecStart = "${pkgs.zfs}/bin/zpool scrub ${envVars.zfsSolidStatePool}";  # Adjust the pool name if needed
    };

    # Enable ZFS trim timer (for SSDs)
    systemd.timers.zfs-trim = {
        enable = true;
        # Set the frequency of the trim (e.g., once a month)
        timerConfig = {
        OnCalendar = "weekly";  # Or adjust this to your preferred schedule
        };
        serviceConfig.ExecStart = "${pkgs.zfs}/bin/zpool trim ${envVars.zfsSolidStatePool}";
    };

    environment.systemPackages = with pkgs; [
        zfs
        zfsutils
    ];

}
