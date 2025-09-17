let
  sources = import ../../npins;
in
import (sources.nixpkgs + "/nixos/lib/eval-config.nix") {
  modules = [
    (sources.nixpkgs + "/nixos/modules/installer/scan/not-detected.nix")
    (sources.disko + "/module.nix")
    (sources.impermanence + "/nixos.nix")
    (sources.home-manager + "/nixos")
    ../../shared/system.nix
    ./dylan-laptop.nix
    ../../shared/desktop.nix
    ../../shared/dylan/home.nix
  ];
}
