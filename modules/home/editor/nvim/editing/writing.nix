{ pkgs, ... }:

let
  goyo = pkgs.vimUtils.buildVimPlugin {
    pname = "goyo-vim";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "junegunn";
      repo = "goyo.vim";
      rev = "master";
      sha256 = "sha256-pDt7T1U1bqKveAq0CBWTtK2mdOzf8IbfmCi1fcpB2c8=";
    };
  };
in
{

  programs.nixvim = {
    extraPlugins = [ goyo ];

    plugins.vimtex = {
      enable = true;
      texlivePackage = null; # Use system texlive
      settings = {
        view_method = "zathura";
        compiler_method = "latexmk";
        compiler_latexmk = {
          options = [
            "-file-line-error"
            "-synctex=1"
            "-interaction=nonstopmode"
          ];
        };
      };
    };

    extraConfigLua = ''
      -- VimTeX keybinds for tex buffers only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          vim.keymap.set("n", "<A-.>", "<cmd>VimtexView<CR>", { buffer = true, desc = "VimTeX View" })
          vim.keymap.set("n", "<A-,>", "<cmd>VimtexTocToggle<CR>", { buffer = true, desc = "VimTeX TOC Toggle" })
        end,
      })
    '';
  };
}
