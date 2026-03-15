{ config, pkgs, ... }:

{
  # Rust development environment
  home.packages = with pkgs; [
    # Rust toolchain
    rustc
    cargo
    rust-analyzer  # LSP for editors
    rustfmt
    clippy

    # Useful tools
    cargo-watch    # Auto-recompile on file change
    cargo-edit     # cargo add/rm/upgrade
    cargo-outdated # Check for outdated dependencies
  ];
}