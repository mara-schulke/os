{ ... }:

{
  imports = [
    ./graphics
    ./audio
    ./packages
    ./system
    ./builder

    ./user.nix
    ./desktop.nix
    ./network.nix
  ];

  system.stateVersion = "25.05";
}
