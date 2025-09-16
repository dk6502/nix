let
  sources = import ../../npins;
  pkgs = import sources.nixpkgs {};
in
{
  wsl = {
    enable = true;
    defaultUser = "dylan";
  };

  environment.systemPackages = with pkgs; [
     (pkgs.callPackage sources.snix {}).snix.cli
     pfetch
  ];
  
  networking.hostName = "wsl";
  time.timeZone = "America/Chicago";
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";
}
