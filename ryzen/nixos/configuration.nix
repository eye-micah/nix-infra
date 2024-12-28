{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}:

let
  envVars = import ./env-vars.nix; 
in
{
  imports = [
    ./hardware-configuration.nix
    ./zfs.nix
    ./provision.nix 
  ];
}
