{
  config,
  lib,
  pkgs,
  ...
}:
let
  sources = import ../../npins;
in
{
  imports = [
    ../../shared/system.nix
    (sources.nixos-wsl + "/modules")
  ];
  wsl = {
    enable = true;
    defaultUser = "dylan";
  };

  environment.systemPackages = with pkgs; [
     (pkgs.callPackage sources.snix {}).snix.cli
  ];
  
  networking.hostName = "wsl";
  time.timeZone = "America/Chicago";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.05";
}
