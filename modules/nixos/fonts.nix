{ config, pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      inter
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.symbols-only
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      wqy_zenhei
    ];

    fontconfig = {
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "Inter" "Noto Sans CJK SC" ];
        serif = [ "Noto Serif CJK SC" ];
      };
    };
  };
}
