let
  sources = import ../npins;
  pkgs = import sources.nixpkgs {};
in {

  environment.persistence."/persist".users.dylan = {
    files = [
      ".bashrc"
      ".bash_profile"
      ".bash_history"
    ];
  };

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = {
      user.name = "dk6502";
      user.email = "dylank@posteo.com";
      credential = {
        helper = "manager";
        credentialStore = "plaintext";
      };
    };
  };

  programs.bash.promptInit = ''
    PS1=' \w λ '
  '';

  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings.experimental-features = "";
    registry.nixpkgs.to = {
      type = "path";
      path = sources.nixpkgs;
    };
    channel.enable = false;
    nixPath = [ "nixpkgs=/etc/nixos/nixpkgs"];
  };


  environment.etc."nixos/nixpkgs".source = builtins.storePath pkgs.path;

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
    (pkgs.writeShellScriptBin '','' ''nix-shell -p $1 --run $1'')
  ];
}
