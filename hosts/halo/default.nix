{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager

    ../../modules/system
    ./hardware-configuration.nix
  ];

  networking.hostName = "halo";

  home-manager.users."mara" = {
    imports = [ ../../modules/home ];

    desktop.windowManager = "gnome";

    home.homeDirectory = "/home/mara";
    home.username = "mara";
    home.stateVersion = "25.11";
    home.packages = [ inputs.deploy.packages.x86_64-linux.default ];
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
    username = "mara";
    realname = "Mara";
  };

  sphere.graphics.gpu.nvidia.enable = true;
}
