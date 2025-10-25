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
      ".local/share/zed"
      ".config/tidal-hifi"
      ".cargo"
      ".xlcore"
      ".ssh"
    ];
  };

  home-manager.sharedModules = [ (sources.plasma-manager + "/modules") ];
  home-manager.users.dylan = {
    home.packages = with pkgs; [
      tidal-hifi
      papers
      gnomeExtensions.blur-my-shell
      gnomeExtensions.desktop-icons-ng-ding
      gnomeExtensions.compiz-windows-effect
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
        "toml"
        "meson"
        "c"
        "glsl"
        "discord-presence"
        "typst"
        "ltex"
        "texlab"
      ];
      extraPackages = with pkgs; [
        zed-discord-presence
      ];
      userSettings = {
        disable_ai = true;
        buffer_font_size = 12;
        buffer_font_family = "Maple Mono";
        ui_font_size = 15;
        ui_font_family = "Adwaita Sans";
        base_keymap = "Emacs";
        theme = {
          mode = "system";
          light = "Ayu Light";
          dark = "GitHub Dark Default";
        };
        dap = {
          CodeLLDB = {
            binary = pkgs.lib.getExe' pkgs.lldb_20 "lldb-dap";
          };
        };
        "experimental.theme_overrides".syntax = {
          comment.font_style = "italic";
          type.font_style = "italic";
          keyword.font_style = "italic";
        };
        lsp.tinymist.settings = {
          exportPdf = "onSave";
          outputPath = "$root/$dir/$name";
        };
        lsp.texlab.settings.texlab.build = {
          executable = "tectonic";
          args = [
             "-X"
             "compile"
             "%f"
             "--untrusted"
             "--synctex"
           ];
        };
        languages.Typst.soft_wrap = "editor_width";
        languages.LaTeX = {
          soft_wrap = "editor_width";
          tab_bar.show = false;
          debugger.show_button = false;
          termina.show_button = false;
        };
      };
    };

    programs.bash.enable = true;

    dconf.settings = {
      "org/gnome/shell" = {
        enabled-extensions = with pkgs.gnomeExtensions; [
          blur-my-shell.extensionUuid
          compiz-windows-effect.extensionUuid
          desktop-icons-ng-ding.extensionUuid
        ];
      };
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        accent-color = "pink";
      };
      "org/gnome/desktop/background" = {
        picture-uri = "file:///home/dylan/.local/share/wallpaper.jpg";
        picture-uri-dark = "file:///home/dylan/.local/share/wallpaper.jpg";
      };
    };

  };
}
