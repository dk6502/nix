{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    hjem = {
        url = "github:feel-co/hjem";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, impermanence, hjem }: {
    nixosConfigurations = {
      dylan-laptop = nixpkgs.lib.nixosSystem {
        modules = [ 
          impermanence.nixosModules.impermanence
          hjem.nixosModules.default
          ./src/desktop.nix
          ./src/dylan-laptop.nix
	  ./src/system.nix	
        ];
      };
    };
  };
}
