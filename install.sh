#!/bin/bash

# Set strict error handling
set -euo pipefail

# Change to the NixOS configuration directory
cd ryzen/nixos || {
    echo "Directory ryzen/nixos not found."
    exit 1
}

# Update the Git repository
echo "Pulling the latest configuration from the Git repository..."
git pull

# Run the NixOS installation with the specified flake
echo "Running nixos-install with flake '.#ryzen'..."
nixos-install --flake .#ryzen --debug

# Display the EFI boot manager entries
echo "Checking EFI boot manager entries..."
efibootmgr

# Display systemd-boot status
echo "Checking systemd-boot status..."
bootctl status

echo "Script execution complete."
