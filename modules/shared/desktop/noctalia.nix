{ config, pkgs, noctalia, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  imports = [
    noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    package = noctalia.packages.${system}.default.override {
      calendarSupport = true;
    };
    settings = {
      bar.position = "top";
    };
  };
}
