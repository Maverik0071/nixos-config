
{ config, pkgs, ... }:
{
  imports = [
     #<nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix>
     <nixpkgs/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares.nix>
    #[ ./installation-cd-graphical-calamares.nix ] 

     ];
    # services.xserver.enable = ["true"];
    # networking.networkmanager.enable = ["false"];
    #nixpkgs.config.allowUnfree = ["true"];
    #services.xserver.windowManager.i3.enable = ["true"];

    # Provide an initial copy of the NixOS channel so that the user
    # doesn't need to run "nix-channel --update" first.
    #<nixpkgs/nixos/modules/installer/cd-dvd/channel.nix> 
    #};
  
    
  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "x86_64-linux";
  services.xserver.enable = true;
  programs.nm-applet.enable = true;
  # networking.networkManager.enable = true;
  services.xserver.windowManager.i3.enable = true;

  environment.systemPackages = [ 
  pkgs.dmenu
  pkgs.rofi
  pkgs.autotiling
  pkgs.lxappearance
  pkgs.xfce.xfce4-terminal
  pkgs.xfce.xfce4-settings
  pkgs.dunst
  pkgs.pavucontrol
  pkgs.jgmenu
  pkgs.nix-zsh-completions
  pkgs.zsh
  pkgs.xfce.thunar
  pkgs.tmux
  pkgs.fzf-zsh
  pkgs.nitrogen
  pkgs.pfetch
  pkgs.neofetch
  pkgs.neovim
  pkgs.picom
  pkgs.networkmanager_dmenu
  pkgs.papirus-folders
  pkgs.papirus-nord
  pkgs.sweet-folders
  pkgs.clipmenu
  pkgs.volumeicon
  pkgs.brightnessctl
  pkgs.clipit
  pkgs.rofi-power-menu
  pkgs.blueberry
  pkgs.hermit
  pkgs.powerline-fonts
  pkgs.noto-fonts
  pkgs.corefonts
  pkgs.libertine
  pkgs.google-fonts
  pkgs.source-code-pro
  pkgs.terminus_font
  pkgs.nerdfonts
  pkgs.terminus-nerdfont
  pkgs.ranger
  pkgs.i3status
  pkgs.pcscliteWithPolkit
  pkgs.pcsctools
  pkgs.scmccid
  pkgs.ccid
  pkgs.pcsclite
  pkgs.opensc
  pkgs.nixos-icons
  pkgs.material-icons
  pkgs.material-design-icons
  pkgs.variety
  pkgs.sweet
  pkgs.calamares
  pkgs.calamares-nixos
  pkgs.calamares-nixos-extensions
  pkgs.adapta-gtk-theme
  

  # pentestting 

    pkgs.nmap
    pkgs.wireshark
    pkgs.masscan
    pkgs.arp-scan
    pkgs.aircrack-ng
    pkgs.bully
    pkgs.lynis
    pkgs.brutespray
    pkgs.sniffglue
    pkgs.dnschef
    pkgs.dsniff
    pkgs.capstone
    pkgs.metasploit
    pkgs.tor
    pkgs.tor-browser
    pkgs.xfce.xfce4-terminal
    pkgs.mtr
    pkgs.netmask
    pkgs.whois
    pkgs.josh
    pkgs.hashcat
    pkgs.badtouch
    pkgs.ipscan
    pkgs.ntp
    pkgs.samba
    pkgs.unicorn
    pkgs.cardpeek
    pkgs.tmux
    pkgs.junkie
    pkgs.wireshark-cli
    pkgs.zeek
    pkgs.direnv
    pkgs.nix-direnv
    pkgs.zsh-powerlevel10k
    pkgs.zsh-nix-shell
    pkgs.zsh-navigation-tools
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-z
    pkgs.zsh-you-should-use
    pkgs.snmpcheck
    pkgs.sipp
    pkgs.vulnix
    pkgs.kalibrate-hackrf
    pkgs.pixiewps
    pkgs.multimon-ng
  
  ];
}

