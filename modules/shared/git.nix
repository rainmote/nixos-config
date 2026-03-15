{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rainmote";
        email = "rainmote@gmail.com";
      };
    };
  };
}