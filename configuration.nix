{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

boot.loader.systemd-boot.enable = true;
boot.loader.efi.canTouchEfiVariables = true;

  nix.settings = {

    substituters = [
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];

   trusted-public-keys = [
    "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
  ];
    experimental-features = [ "nix-command" "flakes" ];
  };


  networking.hostName = "nixos";
  networking.useDHCP = true;
  networking.nameservers = [ 
      "192.168.90.9" 
      "223.5.5.5" # 阿里 DNS 示例
  ];

  time.timeZone = "Asia/Shanghai";

  users.users.one = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    docker
    docker-compose
  ];

  programs.zsh.enable = true;
  programs.nix-ld.enable = true;

  virtualisation.docker = {
    enable = true;

    enableOnBoot = true;
  };
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

  system.stateVersion = "25.11";
}

