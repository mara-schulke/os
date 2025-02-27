{ ... }:

{
  imports = [ ./builder ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  security.pam.enableSudoTouchIdAuth = true;

  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;

  nix.settings.trusted-users = [ "mara.schulke" ];

  users.users."mara.schulke" = {
    name = "mara.schulke";
    home = "/Users/mara.schulke";
  };

  system.stateVersion = 4;
}
