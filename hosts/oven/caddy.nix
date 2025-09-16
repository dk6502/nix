{config, lib, pkgs, ...}: {
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/caddy"
    ];
  };
  services.caddy.enable = true;
  networking.firewall.allowedTCPPorts = [ 80 443 ];
}
