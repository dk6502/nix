{ config, lib, pkgs, ... }:

{
  environment.persistence."/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/etc/NetworkManager"
      "/var/lib/nixos"
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
        ".config/chromium"
      ];
    };
  };


  boot.plymouth = {
    enable = true;
    theme = "matrix";
    themePackages = with pkgs; [
      plymouth-matrix-theme
    ];
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

  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.displayManager.ly = {
    enable = true;
    settings = {
      gameoflife_entropy_interval = 10;
    };
  };

  programs.labwc.enable = true;

  qt = {
    enable = true;
    style = "kvantum";
    platformTheme = "qt5ct";
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
      zathura
      pcmanfm-qt
      libsForQt5.qtstyleplugin-kvantum
      mako
      qjackctl
      tidal-hifi
      helix
      zed-editor
      zed-discord-presence
      arrpc
      iosevka
      nil
    ];


    directory = "/home/dylan";
    files = {
      ".local/share/wallpaper.png".source = ../images/wallpaper.png;
      ".config/helix/config.toml".source = ../config/helix.toml;
      ".config/helix/languages.toml".source = ../config/languages.toml;
      ".config/alacritty/alacritty.toml".source = ../config/alacritty.toml;
      ".config/labwc/menu.xml".source = ../config/menu.xml;
      ".config/labwc/autostart".source = ../config/autostart;
      ".config/labwc/rc.xml".source = ../config/rc.xml;
      ".config/rofi/config.rasi".source = ../config/rofi.rasi;
      ".config/quickshell".source = ../config/quickshell;
      ".config/pcmanfm-qt/default/settings.conf".source = ../config/pcmanfm-qt.conf;
      ".config/qt6ct/colors/DarkDream.colors".source = ../config/DarkDream.colors;
      ".themes/Nightmare".source =../Nightmare;
      ".icons/slick".source = ../slick;
      ".config/Kvantum".source = ../config/Kvantum;
    };
    clobberFiles = true;
  };


  environment.systemPackages = with pkgs; [
    wget
    quickshell
    git-credential-manager
    unzip
    alacritty
    sfwbar
    swaybg
    rofi-wayland
    wl-clipboard
    grim
    slurp
    gsettings-qt
    gsettings-desktop-schemas
    ungoogled-chromium
    comma
  ];
}
