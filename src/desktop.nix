{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/nixos"
      "/var/lib/iwd"
    ];
    users.dylan = {
      directories = [
        "Music"
        "Pictures"
        "Desktop"
        "Documents"
        "Public"
        "Templates"
        ".cache"
        ".local"
        ".vst3"
        ".wine"
        "Bitwig Studio"
        ".BitwigStudio"
        ".config/vesktop"
        ".config/maestral"
        ".config/yabridgectl"
        ".mozilla"
        ".config/tidal-hifi"
      ];
    };
  };


  programs.dconf.profiles.user.databases = [
    {
      lockAll = true; # prevents overriding
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
          accent-color = "blue";
        };
      };
    }
  ];

  services.upower.enable = true;

  nixpkgs.config.allowUnfree = true;
  networking.wireless.iwd = {
    enable = true;
    settings = {
      Settings = {
        AutoConnect = true;
      };
    };
  };

  services.displayManager.ly = {
    enable = true;
    settings = {
      gameoflife_entropy_interval = 10;
    };
  };

  programs.wayfire.enable = true;

  qt = {
    enable = true;
    style = "kvantum";
  };

  fonts.packages = with pkgs; [
    tamzen
  ];

  fonts.fontconfig.defaultFonts.sansSerif = [ "tamzen" ];
  fonts.fontconfig.defaultFonts.monospace = [ "tamzen" ];

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.libinput.enable = true;
  programs.steam.enable = true;

  hjem.users.dylan = {
    enable = true;
    packages = with pkgs; [
      bitwig-studio
      vesktop
      yabridge
      yabridgectl
      wineWowPackages.stable
      qbittorrent
      papirus-icon-theme
      prismlauncher
      maestral
      winetricks
      sioyek
      libsForQt5.qtstyleplugin-kvantum
      mako
      qjackctl
      tidal-hifi
      helix
      arrpc
      iosevka
      nil
      nixd
    ];

    directory = "/home/dylan";
    files = {
      ".local/share/wallpaper.png".source = ../images/wallpaper.png;
      ".local/share/wallpaper.jpg".source = ../images/wallpaper.jpg;
      ".config/helix/config.toml".source = ../config/helix.toml;
      ".config/helix/languages.toml".source = ../config/languages.toml;
      ".config/wayfire/config.ini".source = ../config/wayfire.ini;
      ".config/quickshell".source = ../config/quickshell;
      ".wezterm.lua".source = ../config/wezterm.lua;
      ".icons/slick".source = ../slick;
      ".config/Kvantum".source = ../config/Kvantum;
    };
    clobberFiles = true;
  };

  programs.foot = {
    enable = true;
    theme = "iterm";
    settings = {
      main = {
        font = "Tamsyn:size=11";
      };
      csd = {
        preferred ="client";
        size = 30;
        border-color = "D1D1D1";
        border-width = 1;
      };
      colors = {
        alpha = 0.85;
      };
    };
  };
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    quickshell
    git-credential-manager
    unzip
    lua
    wl-clipboard
    grim
    slurp
    gsettings-qt
    gsettings-desktop-schemas
    comma
    mpv
    feh
    brightnessctl
    kdePackages.dolphin
    file
    xwayland-satellite
  ];
}
