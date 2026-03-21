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
      bar = {
        position = "top";
        floating = true;
        backgroundOpacity = 0.85;
      };
      general = {
        animationSpeed = 1.0;
        radiusRatio = 1.0;
      };
      colorSchemes = {
        darkMode = true;
        useWallpaperColors = true;
      };
    };
  };
}
