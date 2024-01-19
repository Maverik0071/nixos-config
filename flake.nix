{
  description = "Denetsu config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";    

    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
     
      hyprland.url = "github:hyprwm/Hyprland";
    };

  outputs = { self, nixpkgs, hyprland, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}; 
    in 
     {
    
     # nix flakes basic config
     nixosConfigurations.default = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
           ./configuration.nix
           inputs.home-manager.nixosModules.default
          ]; 
          };
       };
     
     }
