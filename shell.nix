let
  sources = import ./npins;
  pkgs = import sources.nixpkgs {};
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      nil
      nixd
      npins
    ];
  }
