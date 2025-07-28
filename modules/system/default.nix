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
    ./builder.nix
  ];

  system.stateVersion = "25.05";
}
