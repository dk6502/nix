{config, lib, pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      user.name = "dkr6";
      user.email = "dylank@posteo.com";
      credential = {
        helper = "manager";
        credentialStore = "secretservice";
      };
    };
  };

  programs.bash.promptInit = ''
    PS1=' \w λ '
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true; # use xkb.options in tty.
  };

  users.users.dylan = {
    isNormalUser = true;
    extraGroups = [ "wheel"  "realtime" "audio" ];
    password = "7538";
  };
}
