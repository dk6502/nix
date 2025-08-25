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

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    gwenview
    okular
    kate
    khelpcenter
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
    ];
    password = "7538";
  };

  hjem.users.dylan = {
    enable = true;
    directory = "/home/dylan";
    files = {
      ".config/kdedefaults/kdeglobals" = {
        source = ./kdedefaults/kdeglobals;
        clobber = true;
      };
      ".config/kdedefaults/plasmarc" = {
        source = ./kdedefaults/plasmarc;
        clobber = true;
      };
      ".local/share/wallpaper.jpg".source = ./images/wallpaper.jpg;
    };
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

