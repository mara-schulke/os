{ inputs, pkgs, ... }:

{
  imports = [ ./builder ];

  nixpkgs.overlays = [
    inputs.rust.overlays.default
    inputs.fonts.overlays.default
  ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = false;

  #security.pam.services.sudo_local.touchIdAuth = lib.mkForce true;

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

  fonts.packages = with pkgs; [
    berkeley-mono
    berkeley-mono-nerd
    ubuntu_font_family
    nerd-fonts.ubuntu-mono
    lmodern
  ];

  system.stateVersion = 4;
}
