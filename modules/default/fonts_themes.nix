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
  

  #fonts, themes 
    hermit
    powerline-fonts
    noto-fonts
    corefonts
    libertine
    google-fonts
    source-code-pro
    terminus_font
    nerdfonts
    terminus-nerdfont
    ranger
    i3status
    pkgs.pcscliteWithPolkit
    pkgs.pcsctools
    pkgs.scmccid
    pkgs.ccid
    pkgs.pcsclite
    pkgs.opensc
    starship
    nixos-icons
    material-icons
    material-design-icons
    luna-icons
    variety
    sweet

   
    fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      jetbrains-mono
      source-han-sans
      open-sans
      terminus-nerdfont
      terminus_font
      terminus_font_ttf
      hackgen-nf-font
      source-han-sans-japanese
      source-han-serif-japanese
      openmoji-color
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Open Sans" "Source Han Sans" ];
      emoji = [ "openmoji-color" ];
    };
  };
  
}
