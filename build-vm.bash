#!/usr/bin/env bash

NIXOS_CONFIG=$(pwd)/conf.nix nixos-rebuild build-vm
