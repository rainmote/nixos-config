{ config, pkgs, lib, dms, dgop, danksearch, niri, ... }:

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
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "com.mitchellh.ghostty.desktop" ];
    };
  };

  # Session variables and PATH
  home.sessionVariables = {
    TERMINAL = "ghostty";
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

  # DankSearch file search
  programs.dsearch.enable = true;

  # Fcitx5 UI configuration
  home.file.".config/fcitx5/conf/classicui.conf".text = ''
    Theme=Material-Color-Blue
    Font="Sans 12"
    Vertical Candidate List=True
  '';
}