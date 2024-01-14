 { config, pkgs, ... }:

  {
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "densetsu";
  home.homeDirectory = "/home/densetsu";

   # Packages that should be installed to the user profile.
  home.packages = [
    pkgs.htop
    pkgs.xfce.xfce4-terminal
    pkgs.vim
    pkgs.neovim
    pkgs.openssh
    pkgs.sshs
    pkgs.bash
    pkgs.zsh
    pkgs.bash-completion
    pkgs.python3
    pkgs.vscodium
    pkgs.btop
    pkgs.brave
    pkgs.pfetch
    pkgs.starship
    pkgs.lf
    pkgs.ranger
    pkgs.wezterm 
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  nixpkgs.config = {
   allowUnfree = true;
   allowUnfreePredicate = _:true;
   
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  }
