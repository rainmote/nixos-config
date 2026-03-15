{
  description = "NixOS system with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
    noctalia.url = "github:noctalia-dev/noctalia-shell";
    noctalia-qs.url = "github:noctalia-dev/noctalia-qs";
  };

  outputs = { self, nixpkgs, home-manager, niri, noctalia, noctalia-qs, ... }:

  let
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      modules = [
        # Host-specific configuration
        ./hosts/nixos/desktop.nix

        # Home Manager integration
        home-manager.nixosModules.home-manager
        noctalia.nixosModules.default

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { niri-flake = niri; inherit noctalia noctalia-qs; };

          home-manager.users.one = {
            imports = [
              ./home.nix          # User global settings
              ./modules/shared    # Shared modules (cross-platform)
              niri.homeModules.niri
            ];
          };
        }
      ];
    };
  };
}