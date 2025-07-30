{ inputs, ... }:

{
  imports = [ ./builder ];

  nixpkgs.overlays = [
    inputs.rust.overlays.default
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [ "mara.schulke" ];
  nix.extraOptions = ''
    experimental-features = nix-command flakes pipe-operators
  '';

  users.users."mara.schulke" = {
    name = "mara.schulke";
    home = "/Users/mara.schulke";
  };

  system.stateVersion = 4;
}
