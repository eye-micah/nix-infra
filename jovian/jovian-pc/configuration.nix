{ inputs, pkgs, ... }:

{

    # networking
    networking.networkmanager.enable = true;
    networking.hostName = "pc";
    # networking.wireless.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    # sound
    sound.enable = true;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    nix.settings.auto-optimise-store = true;

    services.xserver.videoDrivers = ["nvidia"];

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    system.stateVersion = "24.11";

  environment.systemPackages = with pkgs; [
    pkgs.stress
    pkgs.btop
    pkgs.vim
    pkgs.tmux
    pkgs.mangohud
    pkgs.protonup
    pkgs.heroic
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-id/nvme-TEAM_TM8FP4001T_112212200050346_1-part2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-id/nvme-TEAM_TM8FP4001T_112212200050346_1-part1";
    fsType = "vfat";
  };

  hardware = {
    bluetooth.enable = false;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    xone.enable = true;
    pulseaudio.enable = false;
    opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };
    nvidia.modesetting.enable = true;
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

  users = {
    users = {
      steamuser = {
        shell = pkgs.bash;
        uid = 1000;
        isSystemUser = true;
        hashedPassword = "62aadf3934c5f4168df0c579e9fdb35cf0bd2cf722240fc1a0e36c65545e19a3​";
        extraGroups = [
          "wheel"
          "video"
          "input"
        ];
        group = "steamuser";
      };
    };
    groups = {
      steamuser = {
        gid = 1000;
      };
    };
  };
}