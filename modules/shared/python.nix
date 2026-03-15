{ config, pkgs, ... }:

{
  # Python development environment with uv
  home.packages = with pkgs; [
    python3        # Python interpreter
    uv             # Fast Python package manager
    ruff           # Linter & formatter (fast, written in Rust)
    pyright        # LSP for editors
  ];

  # uv environment variables
  home.sessionVariables = {
    UV_CACHE_DIR = "${config.xdg.cacheHome}/uv";
  };
}