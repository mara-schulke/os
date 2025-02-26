{ ... }:

{
  imports = [ ./builder ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  nixpkgs.allowUnfree = true;

  security.pam.enableSudoTouchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix.settings.trusted-users = [ "mara.schulke" ];

  users.users."mara.schulke" = {
    name = "mara.schulke";
    home = "/Users/mara.schulke";
  };

  system.stateVersion = 4;
}
