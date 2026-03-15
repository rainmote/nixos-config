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

  time.timeZone = "Asia/Shanghai";

  # Enable hardware graphics support
  hardware.graphics.enable = true;

  # Enable niri
  programs.niri.enable = true;

  # Enable greetd display manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd niri";
        user = "greeter";
      };
    };
  };

  # Unlock gnome-keyring on login
  services.gnome.gnome-keyring.enable = true;

  system.stateVersion = "25.11";
}