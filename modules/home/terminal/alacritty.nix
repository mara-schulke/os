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
    };
  };
}
