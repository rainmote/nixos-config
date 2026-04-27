{ config, pkgs, lib, dms, dgop, niri, ... }:

{
  # Import DMS modules (niri is configured at NixOS level for DankGreeter)
  imports = [
    dms.homeModules.dank-material-shell
    dms.homeModules.niri
  ];

  # DankMaterialShell configuration
  programs.dank-material-shell = {
    enable = true;
    enableSystemMonitoring = true;
    dgop.package = dgop.packages.${pkgs.system}.default;

    # Niri integration
    niri = {
      enableKeybinds = true;   # Sets static preset keybinds
      enableSpawn = true;      # Auto-start DMS with niri
      includes.enable = false; # Disable separate include files (use inline keybinds)
    };
  };
}