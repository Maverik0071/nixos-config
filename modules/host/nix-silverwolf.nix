
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

# Uncomment for the AMD or Nvidia ( READ WITH CAUTION AND BEFORE YOU UNCOMMENT) 

############ amdgpu setup #############
#   Enable OpenGL
   hardware.opengl = {
    enable = true;
  #  driSupport = true;
  #  driSupport32Bit = true;
  };

  #hardware.opengl.extraPackages = with pkgs; [
  #amdvlk
  #];
   # For 32 bit applications
  #hardware.opengl.extraPackages32 = with pkgs; [
  #driversi686Linux.amdvlk
  #];
  
  # Load nvidia driver for Xorg and Wayland
  #services.xserver.videoDrivers = ["amdgpu"];
    hardware.nvidia = {

    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;
 #   # Fine-grained power management. Turns off GPU when not in use.
 #   # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
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
  boot.loader.systemd-boot.configurationLimit = 10;
  # boot.loader.systemd-boot.edk2-uefi-shell.enable = "true";
  boot.loader.systemd-boot.consoleMode = "0"; # Try "2", "max", or specific resolutions like "1920x1080"
  boot.modprobeConfig.enable = true;
  #services.hddfancontrol.enable = true;
  
  # boot options based on cpu parameters
  # bboot.initrd.kernelModules = ["kvm-intel"];
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

    
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

  networking.hostName = "wolvesden"; # Define your hostname.
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
  xdg.portal.extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.config.common.default = "kde";

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
    #pam_usb
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
    # lunarvim
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
      jetbrains-mono
      powerline-fonts
      corefonts
      google-fonts
      jetbrains-mono
      udev-gothic
      hack-font
   
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
   #programs.waybar = { 
   #enable = true;
   #systemd.target = "hyprland.target";
   #   };
 
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
   #nix.settings.auto-optimise-store = true;
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
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
   
   services.power-profiles-daemon.enable = true;


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
    compositor.name = "hyprland";
    };
    
    services = {
   desktopManager.plasma6.enable = true;
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
