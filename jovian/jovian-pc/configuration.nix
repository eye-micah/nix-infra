{ inputs, pkgs, config, lib, ... }:

{

    # networking
    networking.networkmanager.enable = true;
    networking.hostName = "pc";
    # networking.wireless.enable = true;

    time.timeZone = "America/New_York";

    i18n.defaultLocale = "en_US.UTF-8";

    # sound
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
    device = lib.mkDefault "/dev/disk/by-id/nvme-TEAM_TM8FP4001T_112212200050346_1-part2";
    fsType = lib.mkDefault "ext4";
  };

  fileSystems."/boot" = {
    device = lib.mkDefault "/dev/disk/by-id/nvme-TEAM_TM8FP4001T_112212200050346_1-part1";
    fsType = lib.mkDefault "vfat";
  };

  hardware = {
    bluetooth.enable = false;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    xone.enable = true;
    graphics.enable32Bit = true;
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = true;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  jovian = {
    hardware = {
      has.amd.gpu = false;
    };
    steam = {
      updater.splash = "vendor";
      enable = true;
      autoStart = true;
      user = "deck";
      desktopSession = "plasma";
    };
    steamos.useSteamOSConfig = true;
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  users = {
    users = {
      deck = {
        shell = pkgs.bash;
        uid = 1000;
        isSystemUser = true;
        password = "deck";
        createHome = true;
        home = /home/deck;
        extraGroups = [
          "wheel"
          "video"
          "input"
        ];
        group = "deck";
      };
    };
    groups = {
      deck = {
        gid = 1000;
      };
    };
  };
}