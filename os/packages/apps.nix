{ config, pkgs, ... }:

{
  nixpkgs.overlays = [(self: super: {
    discord = super.discord.overrideAttrs (_: {
      src = builtins.fetchTarball "https://discordapp.com/api/download?platform=linux&format=tar.gz";
    });

    signal-desktop = super.signal-desktop.overrideAttrs (_: {
      src = builtins.fetchurl {
        url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_6.1.0_amd64.deb";
        sha256 = "0z9p4d4gc3024ixw7p808qhddxbb9akccn9ay6rvf7d3dkzi0hpg";
      };
    });
  })];

  environment.systemPackages = with pkgs; [
    alacritty 
    anki
    chromium
    discord
    enpass
    evince
    exercism
    firefox
    libreoffice
    libheif
    mgba
    minecraft
    mypaint
    signal-desktop
    slack
    spotify
    st
    tdesktop
  ];
}
