{ config, pkgs, dms, niri, ... }:

{
  imports = [
    ./hardware-configuration-desktop2.nix
    ../../modules/nixos
    ../../modules/nixos/nvidia.nix
    dms.nixosModules.greeter
    niri.nixosModules.niri
  ];

  # Host-specific boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "desktop2";

  time.timeZone = "Asia/Shanghai";

  # Niri compositor (NixOS level for DankGreeter)
  programs.niri.enable = true;

  # DankGreeter display manager
  programs.dank-material-shell.greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/one";
  };

  # Unlock gnome-keyring on login
  services.gnome.gnome-keyring.enable = true;

  system.stateVersion = "25.11";
}