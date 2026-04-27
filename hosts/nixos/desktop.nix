{ config, pkgs, dms, niri, ... }:

{
  imports = [
    ../../hardware-configuration.nix
    ../../modules/nixos
    dms.nixosModules.greeter
    niri.nixosModules.niri
  ];

  # Host-specific boot configuration
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  time.timeZone = "Asia/Shanghai";

  # Enable hardware graphics support
  hardware.graphics.enable = true;

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

  services.xserver.videoDrivers = ["nvidia"];
  nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  #  "nvidia-x11"
  #];
       

  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    powerManagement.enable = true;
  };

  system.stateVersion = "25.11";
}
