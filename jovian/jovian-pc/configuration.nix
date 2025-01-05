{ pkgs, inputs, ... }:

{

    # networking
    networking.networkmanager.enable = true;
    networking.hostName = "pc";
    # networking.wireless.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    hardware.enableRedistributableFirmware = true;

    # sound
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings.auto-optimise-store = true;

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

    system.stateVersion = "24.11';

  environment.systemPackages = (environment.systemPackages or []) ++ [
    pkgs.stress
    pkgs.btop
    pkgs.vim
    pkgs.tmux
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-id/nvme-TEAM_TM8FP4001T_112212200050346_1-part2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-id/nvme-TEAM_TM8FP4001T_112212200050346_1-part1";
    fsType = "vfat";
  };

  hardware = (hardware or {}) // {
    bluetooth.enable = false;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    xone.enable = true;
  };

  jovian = {
    hardware = {
      has.amd.gpu = false;
      has.nvidia.gpu = true;
    };
    steam = {
      updater.splash = "vendor";
      enable = true;
      autoStart = true;
      user = "steamuser";
      desktopSession = "plasma";
    };
    steamos.useSteamOSConfig = true;
  };

}