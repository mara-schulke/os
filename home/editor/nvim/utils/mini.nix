{ config, pkgs, ... }:

{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      mockDevIcons = true;
      modules = {
        icons = {
          style = "glyph";
        };
        ai = {
          n_lines = 50;
          search_method = "cover_or_next";
        };
      };
    };
  };
}
