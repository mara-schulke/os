{ config, ... }:

{
  imports = [
    ./os/init.nix
    ./system.nix
  ];

  system.stateVersion = "22.05";
}
