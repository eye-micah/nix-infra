{
    modulesPath,
    lib,
    pkgs,
    ...
}:

let
  envVars = import ./env-vars.nix; 
in

{
    imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
        (modulesPath + "/profiles/qemu-guest.nix")
        ./disk-config.nix
    ];

    boot.loader.grub = {
        efiSupport = true;
        efiInstallAsRemovable = true;
    };

    services.openssh.enable = true;

    nixpkgs.config.allowUnfree = true;

    users = {
        groups.${envVars.adminUser} = {};

        users.${envVars.adminUser} = {
            isSystemUser = true;
            shell = pkgs.zsh;
            extraGroups = [ "wheel" "render" "video" "podman" ];
            createHome = true;
            #hashedPassword = "${secretVars.adminPassword}";	
            hashedPassword = "$6$ytTUaT6RAM9I75hu$nzRy./0A7Xz8EiUG1Bn/PBQvSS5Ng7Ui5STlm0Yt1keVFh2d2tjYZjuYGmoY36irrAZdDoEDjDoQRdPT0vNb9/";
            uid = 1000;
            home = "/home/${envVars.adminUser}";
            group = "${envVars.adminUser}";
            openssh.authorizedKeys.keys = [
                "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWawqBRIqOsbk+AElEiR9BDggm2vSnwG5oH3l+h7NYc micah@pc"
            ];
        };

        #users.${envVars.rootlessDockerUser} = {
        #    isNormalUser = true;
        #    shell = pkgs.bash;
        #    extraGroups = [ "video" "render" ];
        #    uid = 1001;
        #};
    };

    programs.zsh.enable = true;

    system.stateVersion = "24.05";
}