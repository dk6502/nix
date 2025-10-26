{
  services.jellyfin = {
    enable = true;
  };
  services.caddy.virtualHosts = {
    "jellyfin.dddk.dev".extraConfig = ''
      reverse_proxy localhost:8096
    '';
  };
  environment.persistence."persist" = {
    directories = ["/var/lib/jellyfin"];
  };
}
