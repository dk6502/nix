{config, lib, pkgs, ...}: {
  environment.persistence."/persist" = {
    directories = [
      "/srv/audio"
    ];
  };
  services.gonic = {
    enable = true;
    settings = {
      music-path = [
        "/srv/audio/music"
      ];
      podcast-path = "/srv/audio/podcasts";
      playlists-path = "/srv/audio/playlists";
    };
  };

  services.caddy.virtualHosts."gonic.dkr6.com".extraConfig = ''
    reverse_proxy http://localhost:4747
  '';
}
