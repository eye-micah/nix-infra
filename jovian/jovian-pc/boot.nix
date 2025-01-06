{...}: {
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.consoleMode = "0";
    boot.loader.efi.canTouchEfiVariables = true;
    boot.tmp.cleanOnBoot = true;

    boot.kernelParams = [
        "mitigations=off"
        "quiet"
        "udev.log_level=3"
        "nvidia-drm.modeset=1"
    ];

    boot.initrd.systemd.enable = true;
    boot.initrd.verbose = false;
    boot.consoleLogLevel = 0;
}