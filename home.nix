{ config, pkgs, ... }:

{
  home.username = "one";
  home.homeDirectory = "/home/one";

  home.stateVersion = "25.11";

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

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "rainmote";
        email = "rainmote@gmail.com";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship.enable = true;

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

 home.sessionVariables = {
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

}

