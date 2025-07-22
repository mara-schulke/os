{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "us";

    autoRepeatDelay = 300;
    autoRepeatInterval = 25;

    displayManager.gdm.enable = true;
    displayManager.defaultSession = "gnome";
    desktopManager.gnome.enable = true;

    libinput.enable = true;
    xkb.options = "eurosign:e,caps:escape";
  };

  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    ubuntu_font_family
    lmodern
  ];
}
