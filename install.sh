#!/usr/bin/env bash

# Set strict error handling
set -euo pipefail

# Change to the NixOS configuration directory
cd ./vms || {
    echo "Directory not found."
    exit 1
}

# Update the Git repository
echo "Pulling the latest configuration from the Git repository..."
git pull

# Run the NixOS installation with the specified flake
#nixos-install --flake .#ryzen --debug
#disko-install 
#nix --extra-experimental-features 'nix-command flakes' run 'github:nix-community/disko/latest#disko-install' -- --write-efi-boot-entries --flake '.#ryzen' --disk main /dev/sda
nix --extra-experimental-features 'nix-command flakes' run github:nix-community/nixos-anywhere -- --write-efi-boot-entries --generate-hardware-config nixos-generate-config ./hardware-configuration.nix --flake .#noCloud --target-host root@192.168.1.172