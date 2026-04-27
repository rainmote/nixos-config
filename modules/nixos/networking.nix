{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "none";

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
