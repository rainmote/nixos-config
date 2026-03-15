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
    # Networking and system tools
    dnsutils # dig, nslookup
    net-tools # ifconfig, netstat
    inetutils # telnet, ftp
    lsof
    procps # ps, top
  ];
}