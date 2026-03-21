{ config, pkgs, inputs, ... }:

{
  # User global settings
  home.username = "one";
  home.homeDirectory = "/home/one";
  home.stateVersion = "25.11";
}