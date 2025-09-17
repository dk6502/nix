let
  sources = import ../../npins;
  pkgs = import sources.nixpkgs {};
in
{
  home-manager.sharedModules = [(sources.plasma-manager + "/modules")];
  home-manager.users.dylan = {
    home.packages = with pkgs; [papirus-icon-theme];
    home.stateVersion = "25.11";
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 0.8;
          blur = true;
        };
      };
    };
    programs.plasma = import ./plasma.nix;
  };
}
