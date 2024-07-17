# nix-modules

{ config, pkgs, modulesPath, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
       ./hardware-configuration.nix
      # ./home
     # ./desktop-packages.nix	
    inputs.home-manager.nixosModules.default
    ];
  
  nix = {
  package = pkgs.nixFlakes;
  extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
    "experimental-features = nix-command flakes";
      };

 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   # bash and zsh 
    nix-bash-completions
    nix-zsh-completions
    zsh-autocomplete
    zsh-autosuggestions
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-fast-syntax-highlighting
    nix-bundle
    nixos-generators
    buildkit-nix
    nix-build-uncached
    nixd
    nix-top
    nix-doc
    nix-pin
    nix-tree
    nix-melt
    nix-info
    nix-diff
    nix-serve
    nix-index
    nix-update
    nix-script
    nix-bundle
    nixos-icons
    nixos-shell
    nix-pluginszx
    nix-search-cli
    nixpkgs-lint
    nixos-option
    nom
    nh
    nvd
    nix-output-monitor

}
