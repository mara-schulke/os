{ inputs, ... }:

let
  vpn = inputs.ocular.lib.vpn;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.ocular.nixosModules.vpn

    ../../modules/system
    ./hardware-configuration.nix
    ./virt.nix
    ./volt
  ];

  networking.hostName = "prisma";

  home-manager.users."mara" = {
    imports = [ ../../modules/home ];

    desktop.windowManager = "gnome";

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

  ocular.vpn = {
    enable = false;
    peer = vpn.peers.maple;
    privateKeyFile = "/root/wireguard/keys/private";
  };

  sphere.graphics.gpu.nvidia.enable = true;

  swapDevices = [
    {
      device = "/swapfile";
      size = 32768; # 32GB in MB
    }
  ];

  system.stateVersion = "26.05";
}
