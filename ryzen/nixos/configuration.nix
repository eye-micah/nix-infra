{
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    ...
}: 

let
    envVars = import ./nixos/env-vars.nix;
in
{
    imports = [
        ./hardware-configuration.nix
        ./zfs.nix
        ./docker/provision.nix
    ]
}