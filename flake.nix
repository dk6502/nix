{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-25.05;
    impermanence.url = github:nix-community/impermanence;
  };

  outputs = { self, nixpkgs, impermanence }: {
    nixosConfigurations = {
      dylan-laptop = nixpkgs.lib.nixosSystem {
        modules = [ 
                  impermanence.nixosModules.impermanence
                  ./desktop.nix
                  ./dylan-laptop.nix
        ];
      };
    };
  };
}
