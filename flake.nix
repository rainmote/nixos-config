{
  description = "NixOS system with Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:

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

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

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