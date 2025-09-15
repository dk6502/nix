{config, lib, pkgs, ...}: {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      user.name = "dkrsix";
      user.email = "dylank@posteo.com";
      credential = {
        helper = "manager";
        credentialStore = "plaintext";
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;
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
    hashedPassword = "$y$j9T$8.fMAkhjGqlgJCqZqAo721$fGUuH27Y4ugQqfITSfNeFoibwQ9U8KCc5yzopIugbvB";
  };

  environment.systemPackages = with pkgs; [

    helix
    git-credential-manager
  ];
}
