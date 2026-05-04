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
  ];

  networking.hostName = "moss";

  home-manager.users."mara" = {
    imports = [ ../../modules/home ];

    desktop.windowManager = "gnome";

    home.homeDirectory = "/home/mara";
    home.username = "mara";
    home.stateVersion = "26.05";
    home.packages = [ inputs.deploy.packages.x86_64-linux.default ];
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
    username = "mara";
    realname = "Mara Schulke";
  };

  ocular.vpn = {
    enable = true;
    peer = vpn.peers.moss;
    privateKeyFile = "/root/wireguard/keys/private";
  };

  system.stateVersion = "26.05";
}
