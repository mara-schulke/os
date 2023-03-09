{ config, pkgs, ... }:

{
  nixpkgs.overlays = [(self: super: {
    slock = super.slock.overrideAttrs (_: {
      src = builtins.fetchTarball {
        url = "https://github.com/mara214/slock/archive/refs/tags/1.4.6.tar.gz";
        sha256 = "0lg5s1l0fzz44liyh9kfnhyka3d9zn8b88xx7naamn8g8rr3s4s1";
      };
    });
  })];

  environment.systemPackages = with pkgs; [
    bind
    binutils
    coreutils
    cmake
    file
    git
    gnumake
    gocryptfs
    htop
    killall
    man-pages
    nix
    playerctl
    unixtools.xxd
    usbutils
    wpa_supplicant_gui
    xfontsel
    xlsfonts
    xclip
    xdotool
    xscreensaver
    xorg.xbacklight
    xorg.xset
    xorg.xmodmap
    xorg.xev
    zsh
  ];
}
