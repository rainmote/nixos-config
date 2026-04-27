{ config, pkgs, ... }:

{
  # NixOS-specific system configuration

  imports = [
    ./docker.nix
    ./i18n.nix
    ./nix.nix
    ./networking.nix
    ./users.nix
  ];

  # Noctalia prerequisites
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;
  services.gnome.evolution-data-server.enable = true;
}