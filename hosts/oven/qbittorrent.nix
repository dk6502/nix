let
  sources = import ../../npins;
  pkgs = import sources.npins;
in
{
  services.qbittorrent = {
    enable = true;
    webuiPort = 6767;

    serverConfig = {
      Preferences = {
        WebUI = {
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
        };
      };
    };
  };
  services.caddy.virtualHosts = {
    "jellyfin.dddk.dev".extraConfig = ''
      reverse_proxy localhost:6767
    '';
  };
  

}
