{ ... }:

{
  imports = [ ./builder ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  security.pam.services.sudo_local.touchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [ "mara.schulke" ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
    "pipe-operators"
  ];
  users.users."mara.schulke" = {
    name = "mara.schulke";
    home = "/Users/mara.schulke";
  };

  system.stateVersion = 4;
}
