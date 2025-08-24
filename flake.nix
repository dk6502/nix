{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-25.05;
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      dylan-laptop = nixpkgs.lib.nixosSystem {
        modules = [ 
                  ./configuration.nix 
        ];
      };
    };
  };
}
