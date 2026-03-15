{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    mouse = true;
    prefix = "C-a";
  };

  programs.tmux.plugins = with pkgs.tmuxPlugins; [
    sensible
    yank
    resurrect
    continuum
  ];
}