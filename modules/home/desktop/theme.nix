{
  inputs,
  pkgs,
  lib,
  ...
}:

let
  font = {
    name = "BerkeleyMono Nerd Font";
    size-small = 12;
    size-medium = 15;
    size-large = 20;
    pkg = pkgs.berkeley-mono-nerd;
  };
in
{
  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.attrs;
    default = font;
    description = "The main system font used across the system.";
  };

  config = {
    desktop.wallpaper = inputs.artworks + "/Shapes/Waves/shockwave-2.jpg";

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
