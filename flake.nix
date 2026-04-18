{
 description = "Mara's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    deploy.url = "github:serokell/deploy-rs";

    nixvim = {
      url = "github:nix-community/nixvim";
    };

    polar.url = "github:hemisphere-systems/polar";

    #fonts = {
    #  url = "git+ssh://git@github.com/hemisphere-systems/fonts";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    #claude = {
    #  url = "git+ssh://git@github.com/mara-schulke/claude";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};

    ocular.url = "git+ssh://git@github.com/hemisphere-systems/ocular";

    colors.url = "github:misterio77/nix-colors";

    #artworks = {
    #  url = "git+ssh://git@github.com/mara-schulke/artworks";
    #  flake = false;
    #};
  };

  outputs =
    { nixpkgs, darwin, home-manager, ... }@inputs:

    let
      args = {
        inherit inputs;
        darwin = null;
      };

      mac = darwin.lib.darwinSystem {
        modules = [ ./hosts/mac ];
        specialArgs = args;
      };

      prisma = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [ ./hosts/prisma ];
      };

      fury = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [ ./hosts/fury ];
      };

      moss = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [ ./hosts/moss ];
      };

      amber = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          overlays = [
            inputs.polar.overlays.default
            #inputs.fonts.overlays.default
            #inputs.claude.overlays.default
          ];
          config = {
            allowUnfree = true;
            allowUnfreePredicate = _: true;
          };
        };
        extraSpecialArgs = {
          inherit inputs;
          username = "mara";
          realname = "Mara Schulke";
        };
        modules = [ ./hosts/amber ];
      };
    in
    {
      nixosConfigurations = {
        # nix run nix-darwin -- switch --flake .#prisma
        inherit prisma;
        # nixos-rebuild switch --flake .#fury
        inherit fury;
        # nix run nix-darwin -- switch --flake .#moss
        inherit moss;
      };

      # nix run nix-darwin -- switch --flake .#mac
      darwinConfigurations = {
        inherit mac;
      };

      # home-manager switch --flake .#amber
      homeConfigurations = {
        inherit amber;
      };

      nixosModules = {
        default = import ./modules/system;
      };

      homeModules = {
        default = import ./modules/home;
      };

      deploy.nodes.fury = {
        hostname = "fury";
        profiles.system = {
          user = "root";
          path = inputs.deploy.lib.x86_64-linux.activate.nixos fury;
        };
      };

      darwinModules = {
        default = import ./modules/darwin;
      };

      checks.aarch64-darwin = {
        canBuild = mac.system;
      };

      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt-rfc-style;
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-tree;
    };
}
