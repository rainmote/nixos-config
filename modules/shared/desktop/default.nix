{ config, pkgs, ... }:

{
  imports = [
    ./niri.nix
    ./noctalia.nix
    ./browsers.nix
  ];
}