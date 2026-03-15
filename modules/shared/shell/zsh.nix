{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Oh My Zsh configuration (plugins only, starship handles prompt)
    oh-my-zsh = {
      enable = true;
      theme = "";  # Empty theme, starship provides the prompt
      plugins = [
        "git"
        "sudo"
        "history"
        "dirhistory"
        "colored-man-pages"
      ];
    };
  };

  programs.starship.enable = true;
}