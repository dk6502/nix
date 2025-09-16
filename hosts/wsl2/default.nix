let
  sources = import ../../npins;
in
import (sources.nixpkgs + "/nixos/lib/eval-config.nix") {
  modules = [
    (sources.nixpkgs + "/nixos/modules/profiles/qemu-guest.nix")
    (sources.disko + "/module.nix")
    (sources.impermanence + "/nixos.nix")
    (sources.nixos-wsl + "/modules/")
    ../../shared/system.nix
    ./wsl2.nix
    ../../shared/openssh.nix
  ];
}
