{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "de";

    autoRepeatDelay = 300;
    autoRepeatInterval = 25;

    displayManager.gdm.enable = true;
    displayManager.defaultSession = "none+xmonad";

    windowManager.xmonad.enable = true;
    windowManager.xmonad.enableContribAndExtras = true;
    windowManager.xmonad.extraPackages = hpkgs: [
      hpkgs.xmonad
      hpkgs.xmonad-contrib
      hpkgs.xmonad-extras
      hpkgs.data-default
    ];

    windowManager.dwm.enable = true;

    xautolock = {
      enable = true;
      locker = "${pkgs.slock}/bin/slock";
    };

    libinput.enable = true;
    xkbOptions = "eurosign:e";
  };

  programs.slock.enable = true;

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    ubuntu_font_family
    lmodern
  ];
}
