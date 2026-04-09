{ pkgs, ... }:

{
  imports = [ ./folding.nix ];

  programs.nixvim = {
    plugins = {
      treesitter = {
        enable = true;

        grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;

        settings = {
          indent.enable = false;
          highlight.enable = true;
        };
      };

      treesitter-textobjects = {
        enable = true;
        settings = {
          select = {
            enable = true;
            lookahead = true;
          };
        };
      };
    };

    extraConfigLua = ''
      vim.cmd("syntax on")
    '';
  };
}
