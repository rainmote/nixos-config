{ config, pkgs, niri-flake, noctalia, noctalia-qs, ... }:

let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  programs.niri.enable = true;
  programs.niri.package = niri-flake.packages.${system}.niri-stable.overrideAttrs (old: {
    doCheck = false;
  });

  home.packages = with pkgs; [
    # Desktop shell and compositor-related
    noctalia-qs.packages.${system}.default

    # Mainstream components
    swaynotificationcenter
    swww
    swaybg
    rofi
    kitty

    # Wallpaper tools
    jq
    curl

    # Theme/Icons
    catppuccin-gtk
    catppuccin-kvantum
    papirus-icon-theme

    # Utilities
    wl-clipboard
    libnotify
    xdg-utils
    grimblast
    swaylock-effects
    swayidle

    # Fonts
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  # Install wallpaper script to ~/.local/bin/
  home.file.".local/bin/niri-wallpaper.sh" = {
    source = ./niri-wallpaper.sh;
    executable = true;
  };

  # Niri configuration
  programs.niri.settings = {
    # Basic settings
    input = {
      keyboard.xkb.layout = "us";
      touchpad = {
        tap = true;
        dwt = true;
      };
    };

    # Layout
    layout = {
      gaps = 12;
      center-focused-column = "never";
      default-column-width = { proportion = 0.5; };
      struts = {
        left = 0;
        right = 0;
        top = 0;
        bottom = 0;
      };
    };

    # Keybinds
    binds = {
      # Terminal
      "Mod+Return".action.spawn = [ "kitty" ];
      
      # Noctalia IPC calls
      "Mod+Space".action.spawn = [ "noctalia-qs" "-c" "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
      "Mod+Shift+C".action.spawn = [ "noctalia-qs" "-c" "noctalia-shell" "ipc" "call" "controlCenter" "toggle" ];
      "Mod+S".action.spawn = [ "noctalia-qs" "-c" "noctalia-shell" "ipc" "call" "settings" "toggle" ];
      
      # Window management
      "Mod+W".action.close-window = { };
      
      # Focus
      "Mod+H".action.focus-column-left = { };
      "Mod+L".action.focus-column-right = { };
      "Mod+J".action.focus-window-down = { };
      "Mod+K".action.focus-window-up = { };
      
      # Move
      "Mod+Shift+H".action.move-column-left = { };
      "Mod+Shift+L".action.move-column-right = { };
      "Mod+Shift+J".action.move-window-down = { };
      "Mod+Shift+K".action.move-window-up = { };
      
      # Resize
      "Mod+R".action.switch-preset-column-width = { };
      "Mod+F".action.maximize-column = { };
      "Mod+Shift+F".action.fullscreen-window = { };
      
      # Screenshots
      "Print".action.spawn = [ "grimblast" "copy" "area" ];
      
      # Audio/Brightness (Generic examples)
      "XF86AudioRaiseVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+" ];
      "XF86AudioLowerVolume".action.spawn = [ "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-" ];
      "XF86AudioMute".action.spawn = [ "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle" ];
    };

    # Window rules for aesthetics
    window-rules = [
      {
        geometry-corner-radius = {
          top-left = 12.0;
          top-right = 12.0;
          bottom-left = 12.0;
          bottom-right = 12.0;
        };
        clip-to-geometry = true;
      }
      {
        matches = [ { is-active = false; } ];
        opacity = 0.95;
      }
    ];

    # Autostart
    spawn-at-startup = [
      { command = [ "swaybg" "-c" "#1e1e2e" ]; }
      { command = [ "noctalia-shell" ]; }
      { command = [ "swww-daemon" ]; }
      { command = [ "bash" "/home/one/.local/bin/niri-wallpaper.sh" ]; }
      { command = [ "swaync" ]; }
    ];
  };

  # Kitty configuration
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Mocha";
    settings = {
      background_opacity = "0.8";
      font_family = "FiraCode Nerd Font";
      font_size = 14;
      window_padding_width = 10;
    };
  };

  # GTK Theme
  gtk = {
    enable = true;
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Breeze_Snow";
      package = pkgs.kdePackages.breeze;
    };
  };
}