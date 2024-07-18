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
 
  # Bootloader 
 # boot.kernalPackages = "pkgs.linuxPackages_latest;
  #boot.loader.grub.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/sda/" ];
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 10;

  
  
  # nix grub generations
  nix.settings.auto-optimise-store = true;
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 5d";
  };

}
