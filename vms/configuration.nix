{
    modulesPath,
    lib,
    pkgs,
    ...
}:
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

    environment.systemPackages = map lib.lowPrio [
        pkgs.curl
        pkgs.gitMinimal
    ];

    users.users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICWawqBRIqOsbk+AElEiR9BDggm2vSnwG5oH3l+h7NYc micah@pc"
    ];

    system.stateVersion = "24.05";
}