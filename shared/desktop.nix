let
  sources = import ../npins;
  pkgs = sources.nixpkgs {};
in
{
  services.displayManager.sddm = {
    enable = true;
  } 
  services.desktopManager.plasma5 = {
    enable = true;
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa
    kate
  ];

  networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [
    ungoogled-chromium
  ];
}
