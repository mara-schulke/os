{ ... }:

{
  imports = [
    ./user.nix
    ./desktop.nix
    ./network.nix

    ./audio/init.nix
    ./graphics/init.nix
    ./packages/init.nix
    ./services/init.nix
    ./system/init.nix
  ];
}
