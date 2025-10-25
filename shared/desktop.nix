let
  sources = import ../npins;
  pkgs = import sources.nixpkgs { };
  lem = import sources.lem {};
in
{
  environment.persistence."/persist" = {
    directories = [
      "/etc/NetworkManager"
    ];
    users.dylan = {
      directories = [
        "Desktop"
        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"
        ".mozilla"
        ".config/vesktop"
        ".gcm"
      ];
    };
  };
  services.displayManager.gdm = {
    enable = true;
  };
  services.desktopManager.gnome = {
    enable = true;
  };
  environment.gnome.excludePackages = with pkgs; [
    baobab
    decibels
    epiphany
    gnome-text-editor
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-disk-utility
    geary
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-system-monitor
    gnome-weather
    loupe
    gnome-connections
    simple-scan
    snapshot
    totem
    yelp
  ];

  programs.dconf.profiles.user.databases = [
    {
      settings = {
        "org/gnome/desktop/interface" = {
          icon-theme = "Papirus";
          cursor-theme = "WhiteSur-cursors";
          monospace-font-name = "Maple Mono";
        };
        "org/gnome/desktop/input-sources" = {
          xkb-options = [ "ctrl:nocaps" ];
        };
      };
    }
  ];

  services.pipewire = {
    enable = true;
    jack.enable = true;
  };
  fonts.packages = with pkgs; [
    maple-mono.truetype
    rubik
    iosevka
  ];

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    vesktop
    papirus-icon-theme
    whitesur-cursors
    nautilus
    thunderbird
    obs-studio
    #(pkgs.callPackage sources.snix {}).snix.cli
  ];
}
