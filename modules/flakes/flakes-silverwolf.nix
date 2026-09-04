{ 
 inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
     chaotic.url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
    # nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel";
    #chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # IMPORTANT

    # Older Version of Nixpkgs
    #nixpkgs-another-version.url = "github:nixos/nixpkgs/nixos-23.11";
    # nixpkgs.follows = "nixos-cosmic/nixpkgs-stable"; # NOTE: change "nixpkgs" to "nixpkgs-stable" to use stable NixOS release

    # nixos-cosmic.url = "github:lilyinstarlight/nixos-cosmic";
      
    home-manager = {
       url = "github:nix-community/home-manager";
      };
  
    hyprland = {
       url = "github:hyprwm/Hyprland";
  	 };
    
    quickshell = {
      url = "git+https://git.outfoxxed.me/quickshell/quickshell";
      #inputs.nixpkgs.follows = "nixpkgs";
        };

     dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      #inputs.nixpkgs.follows = "nixpkgs";
         };

   };

  outputs = { 
  self, 
  nixpkgs,
  quickshell,
  dms,
  chaotic,
  # nixos-cosmic, 
  # home-manager, 
  hyprland, 
  ... 
  } @inputs: let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
    
    # nix flake basic config
    nixosConfigurations = {
      # NOTE: change "host" to your system's hostname
      silverwolf-nix = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
         modules = [
        #   {
        #    nix.settings = {
        #      substituters = [ "https://cosmic.cachix.org/" ];
        #      trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
        #    };
        #  }
        #   nixos-cosmic.nixosModules.default
        #  inputs.home-manager.nixosModules.default
          ./configuration.nix
	  # inputs.nixos-cachyos-kernel.nixosModules.default
	   chaotic.nixosModules.default # IMPORTANT
	#  ./densetsu/boot.nix
      ];
      };
    };
  };
 }
