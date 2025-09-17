{config, lib, pkgs, ...}: {
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/caddy"
      "/srv/state/"
    ];
  };
  services.caddy.enable = true;
  services.caddy.virtualHosts."dkr6.com".extraConfig = ''
    root * /srv/state/doc/snix_eval
    file_server 
  '';
  networking.firewall = {
    allowedTCPPorts = [ 80 22 443 8080 ];
  };
}
