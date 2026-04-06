{
  inputs,
  pkgs,
  lib,
  ...
}:

let
  nixColorsLib = inputs.nix-colors.lib.contrib { inherit pkgs; };

  font = {
    name = "BerkeleyMono Nerd Font";
    size-small = 12;
    size-medium = 15;
    size-large = 20;
    pkg = pkgs.berkeley-mono-nerd;
  };

  colorScheme = {
    slug = "hemisphere-dark";
    name = "hemisphere-dark";
    author = "/";
    variant = "dark";
    palette = {
      base00 = "000000"; # ----
      base01 = "1e1d1c"; # ---
      base02 = "2d2a29"; # --
      base03 = "3a3632"; # -
      base04 = "bdae93"; # +
      base05 = "d5c4a1"; # ++
      base06 = "ebdbb2"; # +++
      base07 = "fbf1c7"; # ++++
      base08 = "fb4934"; # red
      base09 = "fe8019"; # orange
      base0A = "fabd2f"; # yellow
      base0B = "b8bb26"; # green
      base0C = "8ec07c"; # aqua/cyan
      base0D = "83a598"; # blue
      base0E = "d3869b"; # purple
      base0F = "d65d0e"; # brown
    };
  };
in
{
  imports = [
    inputs.nix-colors.homeManagerModules.default
  ];

  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.attrs;
    default = font;
    description = "The main system font used across the system.";
  };

  config = {
    colorScheme = colorScheme;

    home.packages = [
      font.pkg
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
      font = {
        name = font.name;
        package = font.pkg;
        size = font.size-small;
      };
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
