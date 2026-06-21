
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, modulesPath, lib, inputs, home-manager, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
     # inputs.nixos-cosmic.nixosModules.default
     #inputs.home-manager.nixosModules.default
     #./densetsu/boot.nix
    ];
   
  # XWayland
  programs.xwayland = {
  enable = true;
  };
  
  ##################################

  # Bootloader
  #boot.loader.grub.enable = true;
  #boot.loader.grub.efiSupport =false;
  #boot.loader.grub.device = "/dev/sda/";
  #boot.loader.grub.fontSize = "20";
  #boot.loader.grub.configurationLimit = 7;
  #boot.loader.grub.useOSProber = true;
 
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 7;
  # boot.loader.systemd-boot.edk2-uefi-shell.enable = "true";
  boot.loader.systemd-boot.consoleMode = "1"; # Try "2", "max", or specific resolutions like "1920x1080"
  boot.modprobeConfig.enable = true;
  #services.hddfancontrol.enable = true;
  
  # boot options based on cpu parameters
  # bboot.initrd.kernelModules = ["kvm-intel"];
  #boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
   boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true; # by default uses scx_rustland scheduler
  nix.package = pkgs.nix;
    
  #boot kernel parameters
  boot.kernelParams = [
   "quiet"
   "splash"
  ];
  #boot.kernelPackages = pkgs.linuxPackages_latest;

  #direnv
  programs.direnv.enable = true;
  programs.direnv.loadInNixShell = true;
  programs.direnv.nix-direnv.enable = true;
  programs.direnv.silent = true;    

  networking.hostName = "cerberus"; # Define your hostname.
  networking.domain = "example.com";
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Tokyo";

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
  services.xserver = {
  enable = true;
  displayManager.sessionCommands = ''
  xset r rate 200 35 & 
   '';
  };

   # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkbVariant = "";
  };

  # enable flatpak
  services.flatpak.enable = true;
  
  # Automatically add Flathub on boot
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };


  # xdg portals
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.config.common.default = "gtk";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    # pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      ungoogled-chromium
      vlc
    ];
  };

  # for virtualization like gnome-boces or virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # podman
  virtualisation.podman.enable = true;
  # virtualisation.podman.networkSocket.enable = true;

  # docker
  virtualisation.docker.enable = true;
  # virtualisation.podman.dockerSocket.enable = true;
 
  #spices (virtualization)
  services.spice-vdagentd.enable = true;  
 
 
  # ZRAM
  zramSwap.enable = true;
 
  # zsh terminal
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and the command-line tool with nix command settings
  nix.settings.experimental-features = [ "nix-command flakes"];
 
   # Set default editor to vim
  environment.variables.EDITOR = "sublime4";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   # bash and zsh
    nixd
    nix-search-cli
    pkgs.nvd
    nix-output-monitor
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
    nixpkgs-lint
    nixos-option
    nixos-generators
    nix-build-uncached
    nom
    nitch
    nh
    nil

    
    # system packages
    gzip
    wget
    curl
    pkgs.kdePackages.ark
    git
    meson
    gcc
    clang
    zig
    cmake
    ninja
    lm_sensors
    xsensors
    zsh
    tmux
    fastfetch
    lsd
    nitrogen
    pfetch
    gh
    dhcpdump
    btop
    postgresql
    w3m
    usbimager
    distrobox
    lshw
    rPackages.gbm
    gtk-layer-shell
    gvfs
    topgrade
    libvirt
    neocmakelsp
    lua
    toybox
    wayland-protocols
    cheese
    polkit_gnome
    hyprpolkitagent
    flameshot
    # xorg.xkill
    liquidctl
    lm_sensors
   
   # hyprland
    yazi
    yazi-unwrapped
    waypaper  #hyprland
    hyprpaper  #hyprland
    dmenu
    rofi
    mako
    pavucontrol
    jgmenu
    picom
    networkmanager_dmenu
    brightnessctl
    nwg-look   #hyprland
    feh
    wl-clipboard  #hyprland
    wl-clipboard-x11   #hyprland
    wlogout
    hyprpolkitagent
    hyprland-protocols
    libdrm
    wayland    #hyprland
    wayland-protocols    #hyprland
    xdg-desktop-portal-hyprland    #hyprland
    wofi
    kitty   #hyprland
    kitty-themes    #hyprland
    swaybg  #hyprland
    gnumake
    gnumake42

   
    # smartcard applications
    pam_p11
    nss
    nss_latest
    pkgs.pcscliteWithPolkit
    pkgs.pcsc-tools
    pkgs.scmccid
    pkgs.ccid
    pkgs.pcsclite
    pkgs.opensc

   # vim and programming langauges
    vim
    neovim
    vimPlugins.nvim-treesitter-textsubjects
    nodejs_22
    lua
    python3
    flam3
      
   # gaming
    sc-controller
    gamescope
    protonup-qt
    lutris
    steam-run
   
    # applications
    virt-manager
    sublime4
    gnome-boxes
    alacritty
    alacritty-graphics
    kdePackages.okular
    kdePackages.kate
    kdePackages.dolphin
    kdePackages.xdg-desktop-portal-kde
    libreoffice-still 
    hyprpaper
    brave
    ladybird
    zed-editor
    signal-desktop
    signal-cli
    librewolf
    quick-webapps
    proton-vpn
    ptyxis
    claude-code-bin

   # folders and themes
    nixos-icons
    material-icons
    material-design-icons
    sweet-folders
    sweet
    papirus-nord
    papirus-folders
    catppuccin
    ubuntu-themes
    fcitx5-material-color
    stilo-themes
    beauty-line-icon-theme
    adapta-gtk-theme
   
   ];
   
   # fonts, folders, themes, icons
  
    fonts.packages = with pkgs; [
      noto-fonts
      font-awesome
      font-awesome_5
      font-awesome_4
      source-han-sans
      open-sans
      hermit
      openmoji-color
      nerd-fonts.meslo-lg
      meslo-lgs-nf
      source-code-pro
      nerd-fonts.noto
      nerd-fonts.hack
      nerd-fonts.ubuntu
      terminus_font
      terminus_font_ttf
      jetbrains-mono
      powerline-fonts
      corefonts
      google-fonts
      jetbrains-mono
      udev-gothic
      hack-font
      nerd-fonts.hack
 ];    

    # NH environment.sessionVariables
   programs.nh = {
   enable = true;
   clean.enable = true;
   clean.extraArgs = "--keep-since 7d --keep 5";
   flake = "/etc/nixos/";
   };

 
   # Hyprland window manager
   programs.hyprland.enable = true;
   programs.waybar = { 
   enable = true;
   systemd.target = "sway.target";
      };
 
   #withUWSM = true;
   security.pam.services.hyprlock = {};
 

   # nix grub generations
   system.autoUpgrade = {
   enable = true;
   flake = "/etc/nixos/";
   flags = [
   # "nix-update"
    "nixpkgs"
    "-L" # print build logs
   ];
   operation = "boot";
   randomizedDelaySec = "30min";
   dates = "24:00";
      };
   nix.settings.auto-optimise-store = true;
   #nix.gc = {
   #automatic = true;
   #dates = "Sun 24:00";
   #options = "--delete-older-than 7d";
   #  };

    nixpkgs.config.permittedInsecurePackages = [
    "nodejs-12.22.12"
    "python-2.7.18.7"
    "nix-2.17.1"
    "openssl-1.1.1w"
    "qtwebengine-5.15.19"
    "librewolf-151.0.2-1"
    "librewolf-unwrapped-151.0.2-1"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
   
    services = {
    power-profiles-daemon.enable = true;
    tlp.pd.enable = true;
     };


  # List services that you want to enable:
    services.sshd.enable = true;
    services.pcscd.enable = true;
    security.pam.p11.enable = true;
    services.postgresql.enable = true;
    services.tailscale.enable = true;
    services.gvfs.enable = true;
    services.smartd.enable = true;
    services.picom = {
       enable = true;
       backend = "glx";
       fade = true;
       activeOpacity = 1.0;
       inactiveOpacity = 0.9;
       shadowOpacity = 0.9;
       menuOpacity = 0.9;
    };
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;
    #services.pulseaudo.enable = true;

  # list of programs with services
    programs.steam.enable = true;
  #  programs.steam.extest.enable = true;
    programs.gamescope.enable = true;
    programs.zsh.enableLsColors = true;
    programs.zsh.enableCompletion = true;
    programs.zsh.enableBashCompletion = true;
    programs.zsh.autosuggestions.strategy = [
     "history"
      ];
    programs.zsh.autosuggestions.async = true;
    virtualisation.kvmgt.enable = true;
    programs.coolercontrol = {
     enable = true;
   #  nvidiaSupport = false;
       };
      
   # Dank Shell
     programs.dms-shell = {
     enable = true;
     };
   
   # greetd
  #services.greetd = {
  #enable = true;
  ## VT1 = 3;
  #settings = {
  #    default_session = {
  #  command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd i3";
  #command = "dms-greeter --command niri -p /usr/share/quickshell/dms";
  #      };
  #    };
  #  };

      
   # Security Polkit for Military CAC Card
    security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.debian.pcsc-lite.access_pcsc" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
        }
      });
  '';  
             
       
  # cosmic-desktop & other desktop services
  # List services that you want to enable:
  services.displayManager.dms-greeter = {
    enable = true;
    compositor = { 
    name = "hyprland";
    customConfig = ''
      # Optional custom compositor configuration
    '';
  };

  # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
  configHome = "/home/densetsu";

  # Custom config files for non-standard config locations
  configFiles = [
    "/home/densetsu/.config/DankMaterialShell/settings.json"
  ];

  # Save the logs to a file
  logs = {
    save = true; 
    path = "/tmp/dms-greeter.log";
  };

  # Custom Quickshell Package    
  quickshell.package = pkgs.quickshell;
  };


   # sway manager
   programs = {
   sway.enable = true;
      };

    services = {
   # displayManager.ly.enable = true;
   # desktopManager.plasma6.enable = true;
      };

  
  # OpenSSH
  services.openssh.enable = true;
  services.openssh.ports = [
  22 80
   ];

  # Open ports in the firewall
   networking.firewall.allowedTCPPorts = [ 22 80 443 ];
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.11"; # Did you read the comment?

 }
