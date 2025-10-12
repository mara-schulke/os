{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    xkb.layout = "us";
    xkb.options = "eurosign:e,caps:escape";

    autoRepeatDelay = 300;
    autoRepeatInterval = 25;
  };

  services.displayManager = {
    defaultSession = "gnome-xorg";
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  services.desktopManager.gnome.enable = true;
  services.libinput.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.tiling-shell
  ];

  fonts.packages = with pkgs; [
    berkeley-mono
    berkeley-mono-nerd
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    fira-code
    fira-code-symbols
    ubuntu_font_family
    nerd-fonts.ubuntu-mono
    lmodern
  ];
}
