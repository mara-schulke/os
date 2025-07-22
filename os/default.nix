{ ... }:

{
  imports = [
    ./graphics
    ./audio
    ./packages
    ./system

    ./user.nix
    ./desktop.nix
    ./network.nix
  ];

  system.stateVersion = "25.05";
}
