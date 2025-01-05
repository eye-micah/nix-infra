{ pkgs, ... }:

{
    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };

    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia.modesetting.enable = true;

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
        mangohud
        protonup
        heroic
    ];

    programs.gamemode.enable = true;


}