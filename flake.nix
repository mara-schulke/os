{
  description = "Mara's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy.url = "github:serokell/deploy-rs";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    rust = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      darwin,
      home-manager,
      deploy,
      rust,
      ...
    }@inputs:

    let
      mac = darwin.lib.darwinSystem {
        modules = [
          #./darwin/system.nix

          home-manager.darwinModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;

            home-manager.users."mara.schulke" = {
              imports = [ ];
              home.packages = [ deploy.packages.aarch64-darwin.default ];
            };

            nixpkgs = {
              overlays = [
                rust.overlays.default
              ];
              config.allowUnfree = true;
            };

            home-manager.extraSpecialArgs = {
              inherit inputs;
              username = "mara.schulke";
            };
          }
        ];
      };

    in
    {
      # nix run nix-darwin -- switch --flake .#mac
      darwinConfigurations = {
        inherit mac;
      };

      homeModules = {
        default = import ./home;
      };

      checks.aarch64-darwin = {
        canBuild = mac.system;
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
