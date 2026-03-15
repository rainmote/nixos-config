{ config, pkgs, ... }:

{
  # NixOS-specific system configuration

  imports = [
    ./docker.nix
    ./nix.nix
    ./networking.nix
    ./users.nix
  ];
}