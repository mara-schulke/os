{ pkgs, ... }:

let
  mkBase16 = pkgs.callPackage ./colors/lib/base16.nix { };

  gruvbox = mkBase16 {
    name = "base16-gruvbox-dark-hard";
    color00 = "#2d262c";
    color01 = "#fb4934";
    color02 = "#b8bb26";
    color03 = "#fabd2f";
    color04 = "#83a598";
    color05 = "#d3869b";
    color06 = "#8ec07c";
    color07 = "#d5c4a1";
    color08 = "#665c54";
    color09 = "#fb4934";
    color10 = "#b8bb26";
    color11 = "#fabd2f";
    color12 = "#83a598";
    color13 = "#d3869b";
    color14 = "#8ec07c";
    color15 = "#fbf1c7";
  };

  nixos = mkBase16 {
    name = "base16-nixos";
    background = "#0f080e";
    foreground = "#ffebe7";
    color00 = "#2d262c";
    color01 = "#a57e7d";
    color02 = "#a59b80";
    color03 = "#ab877c";
    color04 = "#847aa4";
    color05 = "#a882a0";
    color06 = "#7c849f";
    color07 = "#9e8784";
    color08 = "#4d464c";
    color09 = "#f6b0ad";
    color10 = "#d3d1a0";
    color11 = "#ffc8ae";
    color12 = "#cbb6e9";
    color13 = "#edc3e0";
    color14 = "#cfd3fe";
    color15 = "#ffebe7";
  };

  xcode = mkBase16 {
    name = "base16-xcode";
    foreground = "#ffebe7";
    background = "#080808";
    color00 = "#080808";
    color01 = "#a57e7d";
    color02 = "#a59b80";
    color03 = "#9b777c";
    color04 = "#847aa4";
    color05 = "#a882a0";
    color06 = "#7c849f";
    color07 = "#aaa7a7";
    color08 = "#4d464c";
    color09 = "#f6b0ad";
    color10 = "#d3d1a0";
    color11 = "#ffc8ae";
    color12 = "#cbb6e9";
    color13 = "#edc3e0";
    color14 = "#cfd3fe";
    color15 = "#ffffff";
  };

  matcha = mkBase16 {
    name = "base16-matcha";
    background = "#0c0f08";
    foreground = "#82a889";
    color00 = "#2a2d26";
    color01 = "#a57e7d";
    color02 = "#a59b80";
    color03 = "#ab877c";
    color04 = "#847aa4";
    color05 = "#a882a0";
    color06 = "#7c849f";
    color07 = "#9e9084";
    color08 = "#4b4d46";
    color09 = "#f6adad";
    color10 = "#d3d1a0";
    color11 = "#ffc8ae";
    color12 = "#cbb6e9";
    color13 = "#edc3e0";
    color14 = "#cfd3fe";
    color15 = "#fbffe7";
  };
in
{
  programs.nixvim = rec {

    extraFiles."colors/base16-gruvbox-dark-hard.vim" = {
      enable = true;
      source = ./colors/base16-gruvbox-dark-hard.vim;
    };

    extraFiles."colors/base16-nixos.vim" = {
      enable = true;
      source = ./colors/base16-nixos.vim;
    };

    extraFiles."colors/base16-xcode.vim" = {
      enable = true;
      source = ./colors/base16-xcode.vim;
    };

    extraFiles."colors/base16-matcha.vim" = {
      enable = true;
      source = ./colors/base16-matcha.vim;
    };

    colorschemes = {
      base16.enable = true;
      gruvbox = {
        enable = false;
        settings = {
          contrast = "hard";
          dim_inactive = false;
          invert_selection = true;
          invert_signs = false;
          invert_tabline = false;
          invert_intend_guides = false;
          inverse = false; # invert background for search, diffs, statuslines and errors
          italic = {
            strings = false;
            emphasis = false;
            comments = false;
            operators = false;
            folds = false;
          };
          undercurl = true;
          underline = true;
          bold = true;
          overrides = {
            # Normal = { bg = "#000000"; };
            Normal = {
              bg = "#0E1011";
            };
            SignColumn = {
              link = "LineNr";
            };
          };
        };
      };
    };

    extraConfigLuaPost = ''
      vim.cmd([[
        set t_Co=256
        set termguicolors
        set background=dark
        let base16colorspace=256
        hi Normal ctermbg=NONE
        colorscheme base16-nixos
        call Base16hi("CursorColumn",   "",             g:base16_gui01, "",               g:base16_cterm01, "", "")
        call Base16hi("CursorLine",     "",             g:base16_gui01, "",               g:base16_cterm01, "", "")
        call Base16hi("Comment",        g:base16_gui09, "",             g:base16_cterm09, "",               "", "")
        call Base16hi("LspInlayHint",   g:base16_gui03, "",             g:base16_cterm03, "",               "", "")
        call Base16hi("CocHintSign",    g:base16_gui03, "",             g:base16_cterm03, "",               "", "")
        call Base16hi("NonText",        g:base16_gui01, "",             g:base16_cterm01, "",               "", "")
        call Base16hi("SpecialKey",     g:base16_gui01, "",             g:base16_cterm01, "",               "", "")
      ]])
    '';
  };
}
