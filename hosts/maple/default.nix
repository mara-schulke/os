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
    ./volt
    ./vpn
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

  ocular.vpn = {
    enable = true;
    peer = vpn.peers.maple;
    privateKeyFile = "/root/wireguard/keys/private";
  };

  sphere.graphics.gpu.nvidia.enable = true;
}
