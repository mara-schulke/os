{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    feh
    gnome3.nautilus
    pavucontrol
    system-config-printer
    trayer
    xmobar
  ];
}
