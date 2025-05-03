{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    (chromium.override { enableWideVine = true; })
    discord
    exercism
    firefox
    libreoffice
    libheif
    mgba
    slack
    steam
    spotify
    st
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}
