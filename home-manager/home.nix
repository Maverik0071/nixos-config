{ config. pkgs, ... }:

{
 # Home Manager needs a bit of information about you and the
 # paths it should manage.

 home.username = "densetsu";
 home.homeDirectory = "/home/densetsu";


 programs.home-manager.enable = true;
 home.packages = with pkgs; [
   pkgs.wavemon
   pkgs.ghidra
   pkgs.nmap
   pkgs.metasploit
   pkgs.bandit
   pkgs.bully
   pkgs.ettercap
   pkgs.hydra
   pkgs.i2pd
   pkgs.john
   pkgs.kismet
   pkgs.mosquito
   pkgs.ncracl
   pkgs.nikto
   pkgs.rkhunter
   pkgs.rfdump
   pkgs.reaver
   pkgs.sniffglue
   pkgs.siege
   pkgs.tcpdump
   pkgs.stunnel
   pkgs.veracrypt
   pkgs.sslscan
   pkgs.zenity
   pkgs.aircrack-ng
   pkgs.ethercap
   pkgs.eveilginx
   pkgs.lynis
   pkgs.medusa
   pkgslldb
   pkgs.mdk4
   pkgs.proxychains
   pkgs.shodan
   pkgs.spiderfoot
   pkgs.sherlock
   pkgs.dehashed

    home.stateVersion = "26.11";


  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # tor
  services.tor.enable = true;
  services.tor.relay.enable = true;
  services.tor.client.enable = false;
  services.xserver.enable = true;

  # xsessions
  xsession.enable = true;
  xsession.windowManager.command = "…";
  services.torque.server.enable = TRUE;
  

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  programs.git = {
    enable = true;
    userName = "Jane Doe";
    userEmail = "jane.doe@example.org";
  };


 ];
}
