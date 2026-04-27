{
  inputs,
  pkgs,
  config,
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
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  options.fonts.systemFont.main = lib.mkOption {
    type = lib.types.attrs;
    default = font;
    description = "The main system font used across the system.";
  };

  config = {
    stylix = {
      enable = true;
      polarity = "dark";
      image = config.lib.stylix.pixel "base00";
      base16Scheme = {
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
      fonts = {
        monospace = {
          name = "BerkeleyMono Nerd Font";
          package = pkgs.berkeley-mono-nerd;
        };
        sizes.terminal = 15;
        sizes.applications = 12;
        sizes.desktop = 12;
      };
      cursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 16;
      };
      targets.nixvim.enable = false;
    };

    dconf.settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };
}
