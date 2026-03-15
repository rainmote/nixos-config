{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.nameservers = [
    "192.168.90.9"
    "223.5.5.5"
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      AllowTcpForwarding = true;
      X11Forwarding = true;
      StreamLocalBindUnlink = true;
    };
  };
  networking.firewall.allowedTCPPorts = [ 22 ];
}