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

   #misc
    pasystray
    tlp
    dhcpdump
    lf
    postgresql
    w3m
    usbimager
    wezterm
    xdragon
    lunarvim
    pkgs.ark
    pam_p11
    # pam_usb
    nss
    nss_latest
    acsccid
    distrobox
    pamixer
    teams-for-linux
    ungoogled-chromium
    thrust
    brave
    microsoft-edge-dev

 
}
