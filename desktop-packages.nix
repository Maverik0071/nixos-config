# Do not execute this unless you need to upload all the packages or forget what was there. 
# You can add this to home-manager as well but be careful of uploading this or adding it for now 

#{config, pkgs ...}:

#{
# environment.systemPackages = with pkgs; [
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
    nixd
  #bootstrapping
    wget
    curl
    git
    vim
    arandr
    pkgs.chromium
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
    fanctl
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
    nitrogen
    pfetch
    neofetch
    neovim
    picom
    networkmanager_dmenu
    papirus-folders
    papirus-nord
    sweet
    clipmenu
    volumeicon
    brightnessctl
   # fonts and themes
    hermit
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
    nodejs_21
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
    ciscopacketTracer8
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
}
