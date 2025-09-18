let
  sources = import ../npins;
  pkgs = import sources.nixpkgs {};
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
        ".config/chromium"
        ".config/vesktop"
        ".gcm"
      ];
    };
  };
  services.displayManager.sddm = {
    enable = true;
  };
  services.desktopManager.plasma6 = {
    enable = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kate
    gwenview
    okular
    konsole
  ];

  networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [
    ungoogled-chromium
    vesktop
    alacritty
  ];

}
