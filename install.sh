#!/bin/bash

cd ryzen/nixos 

git pull

nixos-install --flake --debug .#ryzen

efibootmgr

bootctl status