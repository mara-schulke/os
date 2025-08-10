{ inputs, ... }:

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

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  nixpkgs = {
    overlays = [
      inputs.polar.overlays.default
      inputs.fonts.overlays.default
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [ "nix-2.16.2" ];
    };
  };

  system.stateVersion = "25.05";
}
