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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [ "nix-2.16.2" ];
    };
  };

  system.stateVersion = "25.05";
}
