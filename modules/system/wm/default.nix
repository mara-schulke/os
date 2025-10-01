{ ... }:

{
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    enableConfiguredRecompile = true;
    config = builtins.readFile "${./.}/xmonad.hs";
    extraPackages = hpkgs: [
      hpkgs.xmonad
      hpkgs.xmonad-extras
      hpkgs.xmonad-contrib
    ];
  };
}
