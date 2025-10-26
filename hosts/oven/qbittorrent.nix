let
  sources = import ../../npins;
  pkgs = import sources.nixpkgs {};
in
{
  services.qbittorrent = {
    enable = true;
    webuiPort = 6767;

    serverConfig = {
      Preferences = {
        WebUI = {
          HTTPS = {
            enabled = false;
          };
          Username = "dylan";
          Password_PBKDF2 = "G7nDa9KEpx6yg5pH8NU9xA==:JKf1DGzml+7LS8UEECUDZyuVggNj7NsxAsJsnm+CnX3ftshLq1l6V4WHA5OYV3aBVj+CcBooDlmOtUkfbCKfqw==
";
          UseUPNP = false;
          AlternativeUIEnabled = true;
          RootFolder = "${pkgs.vuetorrent}/share/vuetorrent";
        };
      };
    };
  };
  services.caddy.virtualHosts = {
    "qbittorrent.dddk.dev".extraConfig = ''
      reverse_proxy localhost:6767
    '';
  };
  

}
