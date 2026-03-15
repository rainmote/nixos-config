{ config, pkgs, ... }:

{
  # Common packages available across all platforms
  home.packages = with pkgs; [
    htop
    tree
    ripgrep
    fd
    neovim
    tmux
    lazydocker
    nodejs_24
    nodePackages.nrm
  ];
}