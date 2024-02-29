{
  description = "NixOS flake";

  inputs = {
    # nixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    
    # home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.lewin = import ./home.nix;
        }
      ];
    };
  };
}
