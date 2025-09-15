{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, impermanence, hjem, nixos-wsl }: {
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
      wsl = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-wsl.nixosModules.default
          ./modules/system.nix
          ./modules/wsl.nix
          ./modules/services/openssh.nix
        ];
      };
    };
  };
}
