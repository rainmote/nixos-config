{ config, pkgs, dms, niri, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos
    dms.nixosModules.greeter
    niri.nixosModules.niri
  ];

  # Host-specific boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [ "video=2560x1440@60" ];

  networking.hostName = "nixos";

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

  # VMware 虚拟机配置
  virtualisation.vmware.guest.enable = true;

  system.stateVersion = "25.11";
}