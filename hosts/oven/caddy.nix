{config, lib, pkgs, ...}: {
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/caddy"
      "/srv/state/"
    ];
  };
  services.caddy.enable = true;
  services.caddy.virtualHosts."dddk.dev".extraConfig = ''
    file_server
  '';
  services.caddy.virtualHosts = {
    "jellyfin.dddk.dev".extraConfig = ''
      reverse_proxy localhost:8096
    '';
  };
  networking.firewall = {
    allowedTCPPorts = [ 80 22 443 8080 ];
  };
}
