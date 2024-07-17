# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, lib, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
       ./hardware-configuration.nix
      # ./home
     # ./desktop-packages.nix	
    inputs.home-manager.nixosModules.default
    ];

   #vim and programming 
    vimPlugins.nvim-treesitter-textsubjects
    nixos-install-tools
    nodejs_22
    lua
    python3
    clipit
    rofi-power-menu
    blueberry

}
