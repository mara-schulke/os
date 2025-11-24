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

    fonts = {
      url = "git+ssh://git@github.com/hemisphere-systems/fonts";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, darwin, ... }@inputs:

    let
      args = {
        inherit inputs;
        darwin = null;
      };
      mac = darwin.lib.darwinSystem {
        modules = [ ./hosts/mac ];
        specialArgs = args;
      };
      maple = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = args;
        modules = [ ./hosts/maple ];
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

      nixosModules = {
        default = import ./modules/system;
      };

      homeModules = {
        default = import ./modules/home;
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
