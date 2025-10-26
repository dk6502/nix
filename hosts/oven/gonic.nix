{config, lib, pkgs, ...}: {
  services.navidrome = {
    enable = true;
    settings = {
      music-path = [
        "/srv/audio/music"
      ];
      podcast-path = "/srv/audio/podcasts";
      playlists-path = "/srv/audio/playlists";
      db-path = "/var/db/gonic/gonic.db";
    };
  };

  services.caddy.virtualHosts."gonic.dkr6.com" = {
    serverAliases = [ "dkr6.com" "http://gonic.dkr6.com"];
    extraConfig = ''
      reverse_proxy http://localhost:4747
    '';
  };
}
