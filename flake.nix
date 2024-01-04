{
  description = "test";

  inputs =
   {
     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
   };

  outputs = { self,  nixpkgs, ...}:
   let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
   in
   {
     devshells.x86_64-linux.default = pkgs.mkshell { 
	buildInputs =[
	pkgs.nmap
	pkgs.wireshark
        pkgs.metasploit
        pkgs.theharvester 
        pkgs.postgresql
        pkgs.lynis
        pkgs.commix 
      ];
   };
 };
}
