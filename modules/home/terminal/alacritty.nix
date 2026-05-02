{ pkgs, config, lib, ... }:

let
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
        size = lib.mkForce (font.size-medium * 1.0);
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
        primary = {
          background = "#040404";
          foreground = "#f5f0f1";
        };
        normal = {
          black = "#040404";
          red = "#aa6766";
          green = "#a59b80";
          yellow = "#ab877c";
          blue = "#847aa4";
          magenta = "#a882a0";
          cyan = "#7c849f";
          white = "#aaa7a7";
        };
        bright = {
          black = "#4d464c";
          red = "#aa6766";
          green = "#a59b80";
          yellow = "#ab877c";
          blue = "#847aa4";
          magenta = "#a882a0";
          cyan = "#7c849f";
          white = "#f5f0f1";
        };
      };
    };
  };
}
