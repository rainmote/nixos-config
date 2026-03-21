{ config, pkgs, ... }:

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
  ];

  # Session variables and PATH
  home.sessionVariables = {
    npm_config_prefix = "${config.home.homeDirectory}/.npm-global";
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/.npm-global/bin"
    "${config.home.homeDirectory}/.local/bin"
  ];

  home.file.".npmrc" = {
    text = ''
      registry=https://registry.npmmirror.com/
      prefix=${config.home.homeDirectory}/.npm-global
    '';
    force = true;
  };
}