{ lib, inputs, ... }:

{
  imports = [
    ./graphics
    ./audio
    ./packages
    ./system
    ./wm

    ./user.nix
    ./desktop.nix
    ./network.nix
    ./builder.nix
    ./ssh.nix
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  nixpkgs = {
    overlays = [
      inputs.polar.overlays.default
      inputs.fonts.overlays.default
    ];

    config.allowUnfree = lib.mkForce true;
    config.allowUnfreePredicate = lib.mkForce (_: true);
  };
}
