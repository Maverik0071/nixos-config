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
    dunst
    pavucontrol
    zoxide
    feh
    nitrogen
    pfetch
    neofetch
    neovim
    picom
    networkmanager_dmenu
    clipmenu
    volumeicon
    brightnessctl
    ranger
    i3status
    pkgs.pcscliteWithPolkit
    pkgs.pcsctools
    pkgs.scmccid
    pkgs.ccid
    pkgs.pcsclite
    pkgs.opensc
    blueberry
    pasystray
    tlp
    dhcpdump
    postgresql
    w3m
    usbimager
    wezterm
    lunarvim
    pkgs.ark
    pam_p11
    # pam_usb
    nss
    nss_latest
    acsccid
    pamixer
    teams-for-linux
    thrust
    brave
    microsoft-edge-dev

   ];

   environment.sessionVariables = {
   FLAKE = "/etc/nixos/flake.nix";
   };

    nixpkgs.config.permittedInsecurePackages = [
    "nodejs-12.22.12"
    "python-2.7.18.7"
    "nix-2.16.2"
   ];

   # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?



}
