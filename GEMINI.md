# GEMINI.md - NixOS Configuration Guide

This file provides context and instructions for the Gemini CLI when working within this NixOS configuration repository.
dms is mean dank-material-shell

## Project Overview

This repository contains a modular NixOS system configuration using **Nix Flakes** and **Home Manager**. It manages both system-level settings (via NixOS modules) and user-level home directory configuration (via Home Manager) with a clear separation of concerns.

- **Main Technologies:** Nix, NixOS, Home Manager, Nix Flakes.
- **Architecture:** Modular structure with host-specific, NixOS-specific, and shared (cross-platform) modules.
- **Target OS:** NixOS (25.11), with future support planned for macOS (nix-darwin).

## Building and Applying Configuration

### Core Commands

Apply the system configuration (requires root/sudo):
```bash
# Using the convenience script (recommended, uses Chinese mirrors)
./apply.sh

# Manual apply via nixos-rebuild
sudo nixos-rebuild switch --flake .#nixos
```

Other useful Nix commands:
```bash
# Check flake for syntax errors
nix flake check

# Update all flake inputs (nixpkgs, home-manager)
nix flake update

# View the flake's output schema
nix flake show

# Dry-run build without switching
nixos-rebuild build --flake .#nixos
```

## Directory Structure & Conventions

- **`flake.nix`**: The entry point for the configuration. Defines inputs (channels) and outputs (system configurations).
- **`hosts/`**: Contains machine-specific settings.
    - `nixos/desktop.nix`: Bootloader, hostname, and hardware imports for the desktop.
- **`modules/`**: The core logic of the configuration.
    - `nixos/`: System-level NixOS modules (Docker, Networking, Users).
    - `shared/`: User-level Home Manager modules (Zsh, Git, Neovim, Tmux). These are intended to be cross-platform.
- **`home.nix`**: Global Home Manager settings (username, state version).
- **`hardware-configuration.nix`**: Machine-specific hardware detection (usually auto-generated).

### Development Guidelines

1.  **Adding System Features**: Place new `.nix` files in `modules/nixos/` and import them in `modules/nixos/default.nix`.
2.  **Adding User Features**: Place new `.nix` files in `modules/shared/` and import them in `modules/shared/default.nix`.
3.  **Secrets**: **NEVER** commit secrets or API keys to this repository. Use a secret management solution like `sops-nix` or `agenix` if needed (not currently implemented).
4.  **Formatting**: Ensure Nix code is well-formatted. Use `nixpkgs-fmt` or similar if available.

## Key Configuration Details

- **User**: The primary user is `one`.
- **Shell**: Zsh is the default shell, configured with Starship prompt and various plugins.
- **Boot**: Uses `systemd-boot` with EFI support.
- **Mirrors**: Configured to use Tsinghua/USTC mirrors for faster downloads in China.
- **State Version**: `25.11` (ensure this matches when adding new machines).
