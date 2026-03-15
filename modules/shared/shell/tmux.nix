{ config, pkgs, ... }:

let
  tmux-config = pkgs.fetchFromGitHub {
    owner = "gpakosz";
    repo = ".tmux";
    rev = "master";
    hash = "sha256-nXm664l84YSwZeRM4Hsweqgz+OlpyfwXcgEdyNGhaGA=";
  };
in
{
  programs.tmux = {
    enable = true;
    # Source Oh My Tmux!'s main config from the Nix Store
    extraConfig = ''
      source-file ${tmux-config}/.tmux.conf
    '';

    # Nix-managed plugins (pre-installed and sourced automatically)
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      {
        plugin = dracula;
        extraConfig = ''
          set -g @dracula-show-battery false
          set -g @dracula-show-network false
          set -g @dracula-show-weather false
        '';
      }
    ];
  };

  home.file = {
    # Keep the repository in ~/.tmux
    ".tmux" = {
      source = tmux-config;
      recursive = true;
    };

    # Local configuration file (custom settings go here)
    ".tmux.conf.local".source = ./tmux.conf.local;
  };
}
