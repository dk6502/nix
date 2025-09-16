let
  sources = import ../../npins;
in
import (sources.nixpkgs + "/nixos/lib/eval-config.nix") {
  modules = [
    (sources.nixos-wsl + "/modules")
    ../../shared/system.nix
    ./wsl.nix
    ../../shared/openssh.nix
  ];
}
