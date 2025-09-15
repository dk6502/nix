{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    impermanence.url = "github:nix-community/impermanence";
    hjem = {
      url = "github:feel-co/hjem";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, impermanence, hjem, nixos-wsl, disko }: {
    nixosConfigurations = {
      dylan-laptop = nixpkgs.lib.nixosSystem {
        modules = [ 
          impermanence.nixosModules.impermanence
          hjem.nixosModules.default
          ./modules/hosts/dylan-laptop.nix
          ./src/setups/desktop.nix
	        ./src/setups/system.nix
        ];
      };
      wsl = nixpkgs.lib.nixosSystem {
        modules = [
          nixos-wsl.nixosModules.default
          ./modules/hosts/wsl.nix
          ./modules/setups/system.nix
          ./modules/services/openssh.nix
        ];
      };
      oven = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          impermanence.nixosModules.impermanence
          disko.nixosModules.disko
          ./modules/hosts/oven.nix
          ./modules/setups/system.nix
          ./modules/services/openssh.nix
          ./modules/services/gonic.nix
          ./modules/services/caddy.nix
        ];
      }; 
    };
  };
}
