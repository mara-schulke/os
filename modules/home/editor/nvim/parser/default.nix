{ pkgs, ... }:

{
  imports = [ ./folding.nix ];

  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        folding = true;

        nixGrammars = true;
        nixvimInjections = true;

        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;

        settings = {
          indent.enable = false;
          highlight.enable = true;
          fold.enable = true; # add this
        };
      };

      treesitter-textobjects = {
        enable = true;
        select = {
          enable = true;
          lookahead = true;
        };
      };
    };

    extraConfigLua = ''
      vim.cmd("syntax on")

      vim.cmd([[
        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()
      ]])
    '';
  };
}
