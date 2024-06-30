{
  description = "Densetsu config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";    

    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
     
      hyprland.url = "github:hyprwm/Hyprland";
     };

      nixos-gnome.url = "github:Maverik0071/nixos-gnome";

  outputs = { self, nixpkgs, hyprland, home-manager, nixos-gnome, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system}; 
    in 
     {
    
     # nix flakes basic config
     nixosConfigurations = {
      blackwolf-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [ 
          ./configuration.nix
          inputs.home-manager.nixosModules.default
          ]; 
        };
       };
     
     };

     }
