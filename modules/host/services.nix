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
  
  
   environment.systemPackages = with pkgs; [
 # };

  # List services that you want to enable:     
    services.sshd.enable = true;
    services.tlp.enable = true;
    services.pcscd.enable = true;
    services.xserver.xkb.variant = "";
    services.xserver.xkb.layout = "us";
    
    
}
