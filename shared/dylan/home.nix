let
  sources = import ../../npins;
  pkgs = import sources.nixpkgs {};
in
{
  environment.persistence."/persist".users.dylan = {
    directories = [
      ".local/share/kwalletd"
      ".local/share/zed"
    ];
  };
  home-manager.sharedModules = [(sources.plasma-manager + "/modules")];
  home-manager.users.dylan = {
    home.packages = with pkgs; [papirus-icon-theme];
    home.stateVersion = "25.11";
    programs.alacritty = {
      enable = true;
      theme = "github_dark_high_contrast";
      settings = {
        window = {
          opacity = 0.65;
          blur = true;
        };
      };
    };
    programs.helix = {
      enable = true;
      settings = {
        theme = "base16_transparent";
      };
    };

    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor-fhs;
      extensions = ["nix" "github-dark-default" "caddyfile" "dockerfile" "latex"];
      userSettings = {
        disable_ai = true;
        theme = {
          mode = "dark";
          light = "Ayu Light";
          dark = "GitHub Dark Default";
        };
      };
    };

    programs.plasma = import ./plasma.nix;
  };
}
