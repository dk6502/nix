let
  sources = import ../npins;
  pkgs = sources.nixpkgs {};
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

	environment.systempackages = with pkgs; [
    ungoogled-chromium
  ];
}
