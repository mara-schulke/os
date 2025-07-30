{
  description = "Mara's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-25.05";

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
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
    { nixpkgs, darwin, ... }@inputs:

    let
      mac = darwin.lib.darwinSystem { modules = [ ./hosts/mac ]; };
      maple = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
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
    };
}
