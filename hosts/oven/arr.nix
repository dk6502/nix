{
  services.sonarr = {
    enable = true;
    settings = {
      update.mechanism = "builtIn";
      server = {
        urlbase = "localhost";
        port = 8989;
        bindaddress = "*";
      };
    };
  };
  services.caddy.virtualHosts = {
    "sonarr.dddk.dev".extraConfig = ''
      reverse_proxy localhost:8989
    '';
  };
}
