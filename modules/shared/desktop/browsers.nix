{ config, pkgs, ... }:

{
  # Web browsers
  home.packages = with pkgs; [
    firefox
    google-chrome
  ];
}