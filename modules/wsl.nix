{
  config,
  lib,
  pkgs,
  ...
}:

{
  wsl = {
    enable = true;
    defaultUser = "dylan";
  };
  
  networking.hostName = "wsl";
  time.timeZone = "America/Chicago";
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  system.stateVersion = "25.05";
}
