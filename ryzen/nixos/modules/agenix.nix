{ config, pkgs, lib, ... }:
{
  agenix.secrets = {
    "secret-vars.age" = {
      file = ./secrets/secret-vars.age;
      recipients = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHFQy6Jw3QC3ADSbNdRZZSTZMOwB7o/+SQatG4Er2gtC micah@haruka.tail8d76a.ts.net"
      ];
    };
  };
}
