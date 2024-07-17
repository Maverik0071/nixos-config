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

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [

  #bootstrapping
    wget
    curl
    pkgs.gh
    git
    vim
    arandr
    pkgs.chromium-xorg-conf
    meson
    gcc
    clang
    cl 
    zig
    cmake
    meson
    ninja
    libsForQt5.full
    libsForQt5.qt5.qtbase
    qt6.full
    lm_sensors
    xfce.xfce4-sensors-plugin
    xsensors
    qt6.qtbase
    rustc
    rustup
    fanctl
    curlpp
    libgnurl
}
