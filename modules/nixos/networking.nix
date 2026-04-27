{ config, pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    dns = "default";
    appendNameservers = [ "192.168.90.2" "223.5.5.5" ];
  };

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
