let
  sources = import ../../npins;
  pkgs = import sources.nixpkgs {
    config = {
      allowUnfree = true;
    };
  };
in
{
  environment.persistence."/persist".users.dylan = {
    directories = [
      ".local/share/kwalletd"
      ".local/share/zed"
      ".config/tidal-hifi"
    ];
  };
  home-manager.sharedModules = [ (sources.plasma-manager + "/modules") ];
  home-manager.users.dylan = {
    home.packages = with pkgs; [
      papirus-icon-theme
      iosevka
      tidal-hifi
    ];
    home.file.".local/share/wallpaper.jpg".source = ../../assets/wallpaper.jpg;
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

    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    programs.zed-editor = {
      enable = true;
      extensions = [
        "github-dark-default"
        "nix"
      ];
      extraPackages = with pkgs; [
        maple-mono.truetype
      ];
      userSettings = {
        disable_ai = true;
        buffer_font_size = 13;
        buffer_font_family = "Maple Mono";
        ui_font_size = 15;
        ui_font_family = "Inter Displa";
        theme = {
          mode = "system";
          light = "Ayu Light";
          dark = "GitHub Dark Default";
        };
        "experimental.theme_overrides".syntax = {
          comment.font_style = "italic";
          type.font_style = "italic";
          keyword.font_style = "italic";
        };
      };
    };

    programs.bash.enable = true;

    programs.plasma = import ./plasma.nix;
  };
}
