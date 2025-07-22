# TODO!!!!!!!!!!!!!!

{ pkgs, ... }:

let
  font = "Ubuntu Mono";
in
{
  programs.alacritty = {
    enable = true;
    package = pkgs.alacritty;
    settings = {
      # env.TERM = "xterm-256color";
      scrolling.history = 10000;

      terminal.shell.program = "zsh";

      font = {
        size = 15.0;
        normal = {
          family = font;
          style = "Regular";
        };
        bold.family = font;
        italic.family = font;
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

      #scrolling.multiplier = 5;
      selection.save_to_clipboard = true;

      colors = {
        draw_bold_text_with_bright_colors = false;

        primary = {
          background = "0x040404";
          foreground = "0xf5f0f1";
        };

        normal = {
          black = "0x2d262c";
          red = "0xaa6766";
          green = "0xa59b80";
          yellow = "0xab877c";
          blue = "0x847aa4";
          magenta = "0xa882a0";
          cyan = "0x7c849f";
          white = "0xaaa7a7";
        };

        bright = {
          black = "0x4d464c";
          red = "0xf68b95";
          green = "0xd3d1a0";
          yellow = "0xffc8ae";
          blue = "0xcbb6e9";
          magenta = "0xedc3e0";
          cyan = "0xcfd3fe";
          white = "0xffffff";
        };
      };
    };
  };
}
