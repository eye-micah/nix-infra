{ config, pkgs, ... }:

{
  home.stateVersion = "24.11";

  home.packages = [
    pkgs.tmux
    pkgs.vim
    pkgs.utm
    pkgs.btop
    pkgs.zsh
  ];

  home.homeDirectory = builtins.toPath "/Users/micah";
  home.username = "micah";

  programs.home-manager.enable = true;

  home.file.".ssh/config".text = ''
    Host *
      ForwardAgent no
      AddKeysToAgent no
      Compression no
      ServerAliveInterval 0
      ServerAliveCountMax 3
      HashKnownHosts no
      UserKnownHostsFile /dev/null
      StrictHostKeyChecking no
      ControlMaster no
      ControlPath ~/.ssh/master-%r@%n:%p
      ControlPersist no
  '';

  # Zsh
  ## Link the actual zshrc from the Nix folder

  home.file.".zshenv".source = ./dotfiles/zshenv;
  home.file.".zshrc".source = ./dotfiles/zshrc;
  home.file.".zsh_plugins.txt".source = ./dotfiles/zsh_plugins.txt;
  home.file.".vimrc".source = ./dotfiles/vimrc;

  ## Aliases
  programs.zsh = {
      enable = true;
      shellAliases = {
          switch = "darwin-rebuild switch --flake ~/.config/nix";
      };
  };

}

