{ config, pkgs, ... }:

{
  users.users.one = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  # Allow user 'one' to run nixos-rebuild without password
  security.sudo.extraRules = [
    {
      users = [ "one" ];
      commands = [
        {
          command = "${pkgs.nixos-rebuild}/bin/nixos-rebuild *";
          options = [ "NOPASSWD" ];
        }
      ];
    }
  ];

  programs.zsh.enable = true;

  # Required for xdg.portal when using home-manager as NixOS module
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    openssl
    docker
    docker-compose
  ];
}