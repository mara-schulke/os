{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/darwin
  ];

  home-manager.users."mara.schulke" = {
    imports = [ ../../modules/home ];

    home.stateVersion = "24.05";
    home.username = "mara.schulke";
    home.homeDirectory = "/Users/mara.schulke";
    home.packages = [ inputs.deploy.packages.aarch64-darwin.default ];
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
    username = "mara.schulke";
  };
}
