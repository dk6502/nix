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
        ".mozilla"
        ".vst3"
        ".wine"
        "Bitwig Studio"
        ".BitwigStudio"
        ".config/vesktop"
        ".config/maestral"
        ".config/yabridgectl"
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
  
  nixpkgs.config.allowUnfree = true;
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
  services.gnome.core-apps.enable = false;
  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/shell" = {
          favorite-apps = [ "firefox.desktop" "footw.desktop" ];
          enabled-extensions = with pkgs.gnomeExtensions; [
            blur-my-shell.extensionUuid
            gtk4-desktop-icons-ng-ding.extensionUuid
            compiz-windows-effect.extensionUuid
          ];
        };
        "org/gnome/desktop/interface" = {
          accent-color = "pink";
          color-scheme = "prefer-dark";
          icon-theme = "Papirus-Dark";
        };
        "org/gnome/desktop/background" = {
          picture-uri-dark = "file:///home/dylan/.local/share/wallpaper.jpg";
        };
        "com/raggesilver/BlackBox" = {
          theme-dark = "Catppuccin Mocha";
        };
      };
    }
  ];

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
      helix
      maestral
      blackbox-terminal
      thunderbird
      winetricks
];
    directory = "/home/dylan";
    files = {
      ".local/share/wallpaper.jpg".source = ../images/wallpaper.jpg;
      ".local/share/blackbox/schemes/catppuccin-mocha.json".source = ../config/catppuccin-mocha.json;
      ".config/helix/config.toml".source = ../config/helix.toml;
      ".config/helix/languages.toml".source = ../config/languages.toml;
      ".config/alacritty/alacritty.toml".source = ../config/alacritty.toml;
      ".config/gnome-initial-setup-done".text = "yes";
    };
    clobberFiles = true;
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    git-credential-manager
    nautilus
    papers
    unzip
  ] ++ (with pkgs.gnomeExtensions; [
    blur-my-shell
    compiz-windows-effect
    gtk4-desktop-icons-ng-ding
  ]);
}

