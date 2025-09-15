#!/usr/bin/env bash
# https://jade.fyi/blog/pinning-nixos-with-npins/2

cd $(dirname $0)

cmd=${1:-switch}
shift

nixpkgs_pin=$(nix eval --raw -f npins/default.nix nixpkgs)
nix_path="nixpkgs=${nixpkgs_pin}:nixos-config=${PWD}/hosts/$(hostname)/default.nix"

sudo env NIX_PATH="${nix_path}" nixos-rebuild "$cmd" --no-reexec "$@"
