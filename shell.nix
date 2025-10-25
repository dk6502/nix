let
  sources = import ./npins;
  pkgs = import sources.nixpkgs { };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    nil
    nixd
    npins
    (pkgs.writeShellScriptBin ''rebuild'' ''
      $(nix-build --no-link --log-format bar -A config.system.build.toplevel)/bin/switch-to-configuration $@
    '')
    nixos-anywhere
  ];
}
