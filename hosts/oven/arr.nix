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
  environment.persistence."/persist".directories = [
    "/var/lib/sonarr"
    "/var/lib/prowlarr"
    "/var/lib/radarr"
  ];

  services.radarr = {
    enable = true;
    settings = {
      update.mechanism = "builtIn";
      server = {
        urlbase = "localhost";
        port = 7878;
        bindaddress = "*";
      };
    };
  };
  services.caddy.virtualHosts = {
    "radarr.dddk.dev".extraConfig = ''
      reverse_proxy localhost:7878
    '';
  };

  services.prowlarr = {
    enable = true;
    settings = {
      update.mechanism = "builtIn";
      server = {
        urlbase = "localhost";
        port = 9696;
        bindaddress = "*";
      };
    };
  };
  services.caddy.virtualHosts = {
    "prowlarr.dddk.dev".extraConfig = ''
      reverse_proxy localhost:9696
    '';
  };
}
