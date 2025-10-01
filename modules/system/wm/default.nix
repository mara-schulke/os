{ pkgs, ... }:

let
  xmonadPkg = pkgs.haskellPackages.callCabal2nix "xmonad-config" ./. {};
in
{
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    enableConfiguredRecompile = true;
    config = builtins.readFile ./xmonad.hs;
    extraPackages = hpkgs: [
      hpkgs.xmonad
      hpkgs.xmonad-extras
      hpkgs.xmonad-contrib
      xmonadPkg
    ];
  };
}
