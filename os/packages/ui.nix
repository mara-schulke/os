{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    feh
    nautilus
    pavucontrol
    system-config-printer
    trayer
    xmobar
  ];
}
