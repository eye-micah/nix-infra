# Basic ZFS module. Goal is to be nondestructive and simply import existing pools.

{
    services.zfs.enable = true;

    systemd.services.zfs-import = {
        enable = true;
        wantedBy = [ "multi-user.target" ];
        description = "ZFS Pool Import";
        serviceConfig.ExecStart = "${pkgs.zfs}/bin/zpool import ${envVars.zfsSolidStatePool}";
        serviceConfig.ExecStop = "${pkgs.zfs}/bin/zpool export ${envVars.zfsSolidStatePool}";
    };

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