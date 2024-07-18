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
  
  n
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:     
    services.sshd.enable = true;
    services.tlp.enable = true;
    services.pcscd.enable = true;
    services.xserver.xkb.variant = "";
    services.xserver.xkb.layout = "us";
    
    security.polkit.extraConfig =''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.debian.pcsc-lite.access_pcsc" &&
          subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      });
  '';

    services.postgresql.enable = true;
 
  # Enable the OpenSSH daemon.
    services.openssh.enable = true;
  	services.openssh.ports = [
  	  22
  	];

  # services.openssh = {
  # enable = true;
  # require public key authentication for better security
  #settings.PasswordAuthentication = false;
  #settings.KbdInteractiveAuthentication = false;
  #settings.PermitRootLogin = "yes";
  # }; 

 
  #users.users."densetsu".openssh.authorizedKeys.keyFiles = [
  # /etc/nixos/ssh/authorized_keys
  # ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  #networking.interfaces.enp1s0.useDHCP = true;
  #networking.interfaces.wlp2s0.useDHCP = true;
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

}
