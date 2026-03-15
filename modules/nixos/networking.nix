{ config, pkgs, ... }:

{
  networking.nameservers = [
    "192.168.90.9"
    "223.5.5.5"
  ];

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
}