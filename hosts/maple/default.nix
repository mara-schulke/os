{ inputs, ... }:

{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../../modules/system
    ./hardware-configuration.nix
    ./volt
  ];

  networking.hostName = "maple";

  home-manager.users."mara" = {
    imports = [ ../../modules/home ];

    home.homeDirectory = "/home/mara";
    home.username = "mara";
    home.stateVersion = "25.05";
    home.packages = [ inputs.deploy.packages.x86_64-linux.default ];
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
    username = "mara";
    realname = "Mara Schulke";
  };

  sphere.graphics.gpu.nvidia.enable = true;
}
