{
  description = "Mara's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/932a539fe9e3a2080666be2db1fd5a581b748a82";

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
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
      home-manager,
      darwin,
      deploy,
      rust,
      ...
    }@inputs:

    let
      darwinModule = {
        imports = [ ./modules/darwin ];

        nixpkgs.overlays = [
          rust.overlays.default
        ];

        home-manager.users."mara.schulke" = {
          imports = [ ./modules/home ];

          home.stateVersion = "24.05";
          home.username = "mara.schulke";
          home.homeDirectory = "/Users/mara.schulke";
          home.packages = [ deploy.packages.aarch64-darwin.default ];
        };

        home-manager.extraSpecialArgs = {
          inherit inputs;
          username = "mara.schulke";
        };
      };

      mac = darwin.lib.darwinSystem {
        modules = [
          home-manager.darwinModules.home-manager
          darwinModule
        ];
      };

      maple = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          home-manager.nixosModules.home-manager
          {
            imports = [
              ./hosts/maple
              ./builder.nix
              ./modules
            ];

            sphere.graphics.gpu.nvidia.enable = true;
          }
          {
            networking.hostName = "maple";

            home-manager.users."mara" = {
              imports = [ ./modules/home ];

              home.homeDirectory = "/home/mara";
              home.username = "mara";
              home.stateVersion = "25.05";
              home.packages = [ deploy.packages.x86_64-linux.default ];
            };

            home-manager.extraSpecialArgs = {
              inherit inputs;
              username = "mara";
              realname = "Mara Schulke";
            };
          }
        ];
      };
    in
    {
      # nix run nix-darwin -- switch --flake .#maple
      nixosConfigurations = {
        inherit maple;
      };

      # nix run nix-darwin -- switch --flake .#mac
      darwinConfigurations = {
        inherit mac;
      };

      homeModules = {
        default = import ./modules/home;
      };

      darwinModules = {
        default = darwinModule;
      };

      checks.aarch64-darwin = {
        canBuild = mac.system;
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
    };
}
