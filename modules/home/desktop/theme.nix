{
  inputs,
  pkgs,
  lib,
  ...
}:

let
  nixColorsLib = inputs.colors.lib.contrib { inherit pkgs; };

  font = {
    name = "BerkeleyMono Nerd Font";
    size-small = 12;
    size-medium = 15;
    size-large = 20;
    #pkg = pkgs.berkeley-mono-nerd;
  };

  colorScheme = {
    slug = "hemisphere-dark";
    name = "hemisphere-dark";
    author = "/";
    variant = "dark";
    palette = {
      base00 = "040404"; # background
      base01 = "2d262c"; # dark grey
      base02 = "3a3135"; # mid-dark grey
      base03 = "4d464c"; # bright black
      base04 = "aaa7a7"; # light grey
      base05 = "f5f0f1"; # foreground
      base06 = "f5f0f1"; # light foreground
      base07 = "ffffff"; # bright white
      base08 = "aa6766"; # red
      base09 = "f68b95"; # bright red / orange
      base0A = "ab877c"; # yellow
      base0B = "a59b80"; # green
      base0C = "7c849f"; # cyan
      base0D = "847aa4"; # blue
      base0E = "a882a0"; # magenta
      base0F = "ab877c"; # brown
    };
  };
in
{
  imports = [
    inputs.colors.homeManagerModules.default
  ];

  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.attrs;
    default = font;
    description = "The main system font used across the system.";
  };

  config = {
    colorScheme = colorScheme;

    home.packages = [
      #font.pkg
    ];

    home.pointerCursor = {
      enable = true;
      x11.enable = true;
      gtk.enable = true;
      size = 16;
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };

    gtk = {
      enable = true;
      theme = {
        name = colorScheme.slug;
        package = nixColorsLib.gtkThemeFromScheme {
          scheme = colorScheme;
        };
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
