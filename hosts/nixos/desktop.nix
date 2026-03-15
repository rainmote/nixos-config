{ config, pkgs, ... }:

{
  imports = [
    ../../hardware-configuration.nix
    ../../modules/nixos
  ];

  # Host-specific boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.useDHCP = true;

  time.timeZone = "Asia/Shanghai";

  system.stateVersion = "25.11";
}