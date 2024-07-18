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
  
  nix = {
  package = pkgs.nixFlakes;
  extraOptions = lib.optionalString (config.nix.package == pkgs.nixFlakes)
    "experimental-features = nix-command flakes";
      };

  #direnv
  programs.direnv.enable = true;
  programs.direnv.loadInNixShell = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.silent = true;    
 
  # Bootloader 
 # boot.kernalPackages = "pkgs.linuxPackages_latest;
  #boot.loader.grub.enable = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/sda/" ];
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 10;

  networking.hostName = "blackwolf-nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Detroit";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  #services.xserver.autorun = true;
  #services.xserver.layout = "us";
  #services.xserver.desktopManager.default = "none";
  #services.xserver.desktopManager.xterm.enabe = false;
  #services.xserver.displayManager.lightdm.enable = true;
  services.xserver.windowManager.i3.enable = true;  
 
  # Enable the XFCE Desktop Environment.
  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  
  # enable flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
 
  # xdg-portals
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland];
  xdg.portal.config.common.default = "gtk";

  # nh -nixos cli-helper
  # programs.nh = {
  # enable = true;
    # clean.enable = true;
    # clean.extraArgs = "--keep-since 4d --keep 3";
    # flake = "/etc/nixos/flake.nix";
  # };

  # Configure keymap in X11
  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.densetsu = {
    isNormalUser = true;
    description = "densetsu";
    extraGroups = [ "networkmanager" "wheel" "dialout" "inputs"];
    packages = with pkgs; [
       vim
       neovim
       nixos-install-tools
       firefox
       ungoogled-chromium
       openssh
       lunarvim
       pkgs.gh 
    #  thunderbird
    ];
  };

  #home-manager = {
  # also pass inputs to home-manager modules
  #extraSpecialArgs = {inherit inputs;};
  #users = {
  #  "densetsu" = import ./home.nix;
  #  };
  #};

  # for virtualization like gnome-boces or virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.podman.enable = true;
 
  #spices (virtualization)
  services.spice-vdagentd.enable = true;  
  
  # for enabling Hyprland Window manager
  programs.hyprland.enable = true;

  # LF file manager
  # programs.lf.enable = true;

  # ZRAM
  zramSwap.enable = true;

  # zsh terminal
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
 
  # Enable Flakes and the command-line tool with nix command settings 
  nix.settings.experimental-features = [ "nix-command flakes" ];

  # Set default editor to vim
  environment.variables.EDITOR = "lunarvim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   
  # bash and zsh 
    nix-bash-completions
    nix-zsh-completions
    zsh-autocomplete
    zsh-autosuggestions
    zsh-powerlevel10k
    zsh-syntax-highlighting
    zsh-history-substring-search
    zsh-fast-syntax-highlighting
    nix-bundle
    nixos-generators
    buildkit-nix
    nix-build-uncached
    nixd
    nix-top
    nix-doc
    nix-pin
    nix-tree
    nix-melt
    nix-info
    nix-diff
    nix-serve
    nix-index
    nix-update
    nix-script
    nix-bundle
    nixos-icons
    nixos-shell
    nix-plugins
    nix-search-cli
    nixpkgs-lint
    nixos-option
    nom
    nh
    nvd
    nix-output-monitor

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

  #fonts and themes
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

   #vim and programming 
    vimPlugins.nvim-treesitter-textsubjects
    nixos-install-tools
    nodejs_22
    lua
    python3
    clipit
    rofi-power-menu
    blueberry

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
    zed-editor

   #hyprland
    hyprland
    xdg-desktop-portal-hyprland
    rPackages.gbm
    hyprland-protocols
    libdrm
    wayland-protocols
    waybar
    wofi
    kitty
    kitty-themes
    swaybg
   #waybar
    gtkmm3
    gtk-layer-shell
    jsoncpp
    fmt
    wayland
    spdlog
    # libgtk-3-dev #[gtk-layer-shell]
    gobject-introspection #[gtk-layer-shell]
    # libpulse #[Pulseaudio module]
    libnl #[Network module]
    libappindicator-gtk3 #[Tray module]
    libdbusmenu-gtk3 #[Tray module]
    libmpdclient #[MPD module]
    # libsndio #[sndio module# ]
    libevdev #[KeyboardState module]
    # xkbregistry
    upower #[UPower battery module]
    nwg-look
    feh
    wl-clipboard
    wlogout 
   ];

   environment.sessionVariables = {
   FLAKE = "/etc/nixos/flake.nix";
   };

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
  
  # nix grub generations
  nix.settings.auto-optimise-store = true;
  nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 5d";
  };

    nixpkgs.config.permittedInsecurePackages = [
    "nodejs-12.22.12"
    "python-2.7.18.7"
    "nix-2.16.2"
  ];
  
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
