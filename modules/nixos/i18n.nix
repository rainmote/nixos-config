{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-gtk
      qt6Packages.fcitx5-chinese-addons
      fcitx5-rime
      fcitx5-material-color
      fcitx5-pinyin-zhwiki
    ];
  };

  environment.sessionVariables = {
    # GTK_IM_MODULE = "fcitx"; # Often causes issues in Wayland
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
}