let
  githubPublicKey = builtins.readFile (builtins.fetchurl {
    url = "https://github.com/eye-micah.keys";
  });
in
{ config, pkgs, lib, ... }:
{
  agenix.secrets = {
    "secret-vars.age" = {
      file = ./secret-vars.age;
      recipients = [
        lib.concatStringsSep "\n" (lib.splitString "\n" githubPublicKey);
      ];
    };
  };
}
