let
  sources = import ../../npins;
in
import (sources.nixpkgs + "/nixos/lib/eval-config.nix") {
  modules = [
    (sources.nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
    (sources.disko + "/module.nix")
    (sources.impermanence + "/nixos.nix")
    ../../shared/system.nix
    ./oven.nix
    ./caddy.nix
    ./qbittorrent.nix
    ./arr.nix
    ../../shared/openssh.nix
    ./jellyfin.nix
    ./komga.nix
  ];
}
