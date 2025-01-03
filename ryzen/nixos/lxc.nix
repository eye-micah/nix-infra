{ lib, pkgs, config, ... }: let
  # Default values for LXC configuration
  defaults = {
    hostname = "nixos";
    user = "tempuser";
    password = "somepass";
    timeZone = "America/New_York";
    defaultLocale = "en_US.UTF-8";
  };

  # Merge defaults with any provided overrides
  lxcConfig = lib.mkOverride 10 (lib.mkMerge [defaults config.lxc or {}]);
in {
  imports = [
    "${config.modulesPath}/virtualisation/lxc-container.nix"
  ];

  boot.isContainer = true;
  networking.hostName = lxcConfig.hostname;

  environment.systemPackages = with pkgs; [ vim ];

  services.openssh.enable = true;

  time.timeZone = lxcConfig.timeZone;

  i18n = {
    defaultLocale = lxcConfig.defaultLocale;
    extraLocaleSettings = {
      LC_ADDRESS = lxcConfig.defaultLocale;
      LC_IDENTIFICATION = lxcConfig.defaultLocale;
      LC_MEASUREMENT = lxcConfig.defaultLocale;
      LC_MONETARY = lxcConfig.defaultLocale;
      LC_NAME = lxcConfig.defaultLocale;
      LC_NUMERIC = lxcConfig.defaultLocale;
      LC_PAPER = lxcConfig.defaultLocale;
      LC_TELEPHONE = lxcConfig.defaultLocale;
      LC_TIME = lxcConfig.defaultLocale;
    };
  };

  users = {
    mutableUsers = false;
    users."${lxcConfig.user}" = {
      isNormalUser = true;
      password = lxcConfig.password;
      extraGroups = ["wheel"];
    };
  };

  security.sudo.extraRules = [
    {
      users = [lxcConfig.user];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];

  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

}
