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
    openssl
    ghostty
    # CLI tools
    yazi           # TUI file manager
    nh             # Nix helper
    nix-output-monitor # nom - build monitor
    zoxide         # Smart cd
    bat            # Cat with syntax highlighting
    # Wayland tools
    kooha          # Screen recorder for Wayland
    grim           # Screenshot tool
    slurp          # Area selector for grim
    wl-clipboard   # Clipboard manager for Wayland
    swappy         # Screenshot editor
    # Wallpaper tools
    jq             # JSON processor
    libnotify      # Desktop notifications
    swww           # Wallpaper setter for Wayland
    variety        # Wallpaper changer with wallhaven support
    # Development tools
    devenv         # Development environment manager
    direnv         # Auto-load nix dev environments
    opencode       # AI coding assistant TUI
    gemini-cli     # Google Gemini AI CLI
    codex          # OpenAI Codex CLI
    # Browsers
    firefox
    google-chrome
    # Media and apps
    vlc
    telegram-desktop
    libreoffice
  ] ++ [
    # Obsidian with Wayland support
    (pkgs.obsidian.override {
      commandLineArgs = [
        "--enable-features=UseOzonePlatform"
        "--ozone-platform=wayland"
        "--enable-wayland-ime"
      ];
    })
  ];
}