{ config, pkgs, lib, dms, dgop, danksearch, niri, osConfig, ... }:

{
  # Shared modules for Home Manager
  imports = [
    ./core.nix
    ./git.nix
    ./python.nix
    ./rust.nix
    ./shell/zsh.nix
    ./shell/tmux.nix
    ./editors/nvim.nix
    ./desktop
    danksearch.homeModules.default
  ];

  # Terminal configuration
  # Use Alacritty for 'nixos' host (VMware) and Ghostty for others (like 'desktop2')
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = if (osConfig.networking.hostName == "nixos") 
                then [ "Alacritty.desktop" ]
                else [ "com.mitchellh.ghostty.desktop" ];
    };
  };

  # Ghostty configuration
  xdg.configFile."ghostty/config".text = ''
    # Font settings
    font-family = "JetBrainsMono Nerd Font"
    font-size = 12
  '';

  # Alacritty configuration
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        size = 12;
      };
      window.opacity = 0.95;
    };
  };

  # Session variables and PATH
  home.sessionVariables = {
    TERMINAL = if (osConfig.networking.hostName == "nixos") 
               then "alacritty"
               else "ghostty";
    npm_config_prefix = "${config.home.homeDirectory}/.npm-global";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.file.".npmrc".text = ''
    registry=https://registry.npmmirror.com/
    prefix=${config.home.homeDirectory}/.npm-global
  '';

  # Pointer cursor configuration (macOS style)
  home.pointerCursor = {
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  # DankSearch file search
  programs.dsearch.enable = true;

  # Fcitx5 UI configuration
  home.file.".config/fcitx5/conf/classicui.conf" = {
    text = ''
      Theme=Material-Color-Blue
      Font="Sans 12"
      Vertical Candidate List=True
    '';
    force = true;
  };

  # Fcitx5 profile configuration (Enable Pinyin)
  home.file.".config/fcitx5/profile" = {
    text = ''
      [Groups/0]
      Name=Default
      Default Layout=us
      DefaultIM=pinyin

      [Groups/0/Items/0]
      Name=keyboard-us
      Layout=

      [Groups/0/Items/1]
      Name=pinyin
      Layout=

      [GroupOrder]
      0=Default
    '';
    force = true;
  };
}