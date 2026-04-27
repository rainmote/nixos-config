{
  description = "NixOS system with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, dms, dgop, niri, ... }:

  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = { inherit dms niri; };

      modules = [
        # Host-specific configuration
        ./hosts/nixos/desktop.nix

        # System platform
        { nixpkgs.hostPlatform = "x86_64-linux"; }

        # Home Manager integration
        home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit dms dgop niri; };

          home-manager.users.one = {
            imports = [
              ./home.nix          # User global settings
              ./modules/shared    # Shared modules (cross-platform)
            ];
          };
        }
      ];
    };
  };
}
