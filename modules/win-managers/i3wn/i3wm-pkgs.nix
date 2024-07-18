
{ config, pkgs, modulesPath, lib, inputs, ... }:


  
 
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   

   #i3wm pkgs
    dmenu
    rofi
    autotiling
    lxappearance
    xfce.xfce4-terminal
    xfce.xfce4-settings
    dunst
    pavucontrol
    jgmenu
    nix-zsh-completions
    zsh
    tmux
    fzf-zsh
    fzf
    zoxide
    feh
    nitrogen
    pfetch
    neofetch
    neovim
    nitch
    picom
    networkmanager_dmenu
    papirus-folders
    papirus-nord
    sweet
    clipmenu
    volumeicon
    brightnessctl

}
