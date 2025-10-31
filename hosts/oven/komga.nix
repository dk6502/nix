{
  services.komga = {
    enable = true;
    settings.server.port = 6161;
  };
  services.caddy.virtualHosts = {
    "komga.dddk.dev".extraConfig = ''
      reverse_proxy localhost:6161
    '';
  };
}
