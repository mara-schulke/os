{ pkgs, config, ... }:

let
  colorScheme = config.colorScheme.palette;
  font = config.fonts.systemFont.main;
in
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      scrolling.history = 10000;

      terminal.shell.program = "zsh";

      font = {
        size = font.size-medium * 1.0;
        normal = {
          family = font.name;
          style = "Regular";
        };
        bold.family = font.name;
        italic.family = font.name;
      };

      window = {
        title = "alacritty";
        decorations = "full";
        startup_mode = "Windowed";
        dynamic_padding = true;
        option_as_alt = "Both";
        padding = {
          x = 10;
          y = 10;
        };
      };

      selection.save_to_clipboard = true;

      colors = {
        draw_bold_text_with_bright_colors = false;

        primary = {
          background = "0x${colorScheme.base00}";
          foreground = "0x${colorScheme.base07}";
        };

        normal = {
          black = "0x${colorScheme.base00}";
          red = "0x${colorScheme.base08}";
          green = "0x${colorScheme.base0B}";
          yellow = "0x${colorScheme.base0A}";
          blue = "0x${colorScheme.base0D}";
          magenta = "0x${colorScheme.base0E}";
          cyan = "0x${colorScheme.base0C}";
          white = "0x${colorScheme.base05}";
        };

        bright = {
          black = "0x${colorScheme.base03}";
          red = "0x${colorScheme.base08}";
          green = "0x${colorScheme.base0B}";
          yellow = "0x${colorScheme.base0A}";
          blue = "0x${colorScheme.base0D}";
          magenta = "0x${colorScheme.base0E}";
          cyan = "0x${colorScheme.base0C}";
          white = "0x${colorScheme.base07}";
        };
      };
    };
  };
}
