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
      ];
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "dylan-laptop"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

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
      lockAll = true;
      settings = {
        "org/gnome/shell" = {
          favorite-apps = [ "firefox.desktop" "alacritty.desktop" ];
        };
        "org/gnome/desktop/interface" = {
          accent-color = "pink";
          color-scheme = "prefer-dark";
          icon-theme = "Papirus-Dark";
        };
        "org/gnome/desktop/background" = {
          picture-uri-dark = "file:///home/dylan/.local/share/wallpaper.jpg";
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

  users.users.dylan = {
    isNormalUser = true;
    extraGroups = [ "wheel"  "realtime" "audio" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      bitwig-studio
      vesktop
      yabridge
      yabridgectl
      wineWowPackages.stable
      qbittorrent
      papirus-icon-theme
      whitesur-kde
    ];
    password = "7538";
  };

  hjem.users.dylan = {
    enable = true;
    directory = "/home/dylan";
    files = {
      ".local/share/wallpaper.jpg".source = ./images/wallpaper.jpg;
    };
    clobberFiles = true;
  };

  programs.firefox.enable = true;
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      user.name = "dkr6";
      user.email = "dylank@posteo.com";
      credential = {
        helper = "manager";
        credentialStore = "secretservice";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    git-credential-manager
    alacritty
  ];



  system.stateVersion = "25.05"; # Did you read the comment?

}

