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

  palette = {
    base00 = "040404";
    base01 = "2d262c";
    base02 = "3a3135";
    base03 = "4d464c";
    base04 = "aaa7a7";
    base05 = "f5f0f1";
    base06 = "f5f0f1";
    base07 = "ffffff";
    base08 = "aa6766";
    base09 = "f68b95";
    base0A = "ab877c";
    base0B = "a59b80";
    base0C = "7c849f";
    base0D = "847aa4";
    base0E = "a882a0";
    base0F = "ab877c";
  };
in
{
  options = {
    fonts.systemFont.main = lib.mkOption {
      type = lib.types.attrs;
      default = font;
      description = "The main system font used across the system.";
    };

    theme.colors = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = palette;
      description = "Base16 color palette (hex without leading #).";
    };
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
