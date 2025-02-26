{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./colorscheme
    ./editing
    ./filepicker
    ./greeter
    ./lsp
    ./statusline
    ./utils
    ./windows
  ];

  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    clipboard = {
      register = "unnamedplus";
    };
    opts =
      let
        core = {
          autoindent = true;
          backspace = "indent,eol,start";
          backup = false; # creates a backup file
          cmdheight = 1; # space in the neovim command line for displaying messages
          colorcolumn = "80"; # fixes indentline for now
          conceallevel = 0; # so that `` is visible in markdown files
          cursorcolumn = true;
          cursorline = true; # highlight the current line
          fileencoding = "utf-8"; # the encoding written to a file
          hidden = true; # required to keep multiple buffers and open multiple buffers
          hlsearch = true; # highlight all matches on previous search pattern
          ignorecase = true; # ignore case in search patterns
          laststatus = 2;
          mouse = "a";
          compatible = false;
          number = true; # set numbered lines
          pumheight = 10; # pop up menu height
          relativenumber = true; # set relative numbered lines
          signcolumn = "yes"; # always show the sign column otherwise it would shift the text each time
          smartcase = true; # smart case
          spell = false;
          spelllang = "en";
          swapfile = false; # creates a swapfile
          title = true; # set the title of window to the value of the titlestring
          titlestring = "%<%F%=%l/%L - nvim"; # what the title of the window will be set to
          undofile = true; # enable persistent undo
          updatetime = 100; # faster completion
          wildignore = "*.pyc,*.o,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.*";
          wrap = false; # display lines as one long line
          writebackup = false; # if a file is being edited by another program (or was written to file while editing with another program) it is not allowed to be edited
        };

        tabs = {
          expandtab = true; # convert tabs to spaces
          shiftwidth = 4; # the number of spaces inserted for each indentation
          showtabline = 1; # only show tabs if there's more than one
          smartindent = true; # make indenting smarter again
          smarttab = true;
          tabstop = 4; # insert 2 spaces for a tab
        };

        folding = {
          # filetype = false;
          foldenable = true;
          foldexpr = "nvim_treesitter#foldexpr()";
          foldlevel = 99;
          foldlevelstart = 99;
          foldmethod = "expr";

          list = true;
          listchars = "tab:➞\\t,extends:›,precedes:‹,nbsp:·,trail:·,space:·";
          scrolloff = 8;
          showmode = false;
          sidescrolloff = 8;
        };

        splits = {
          splitbelow = true; # force all horizontal splits to go below current window
          splitright = true; # force all vertical splits to go to the right of current window
        };

        search = {
          gdefault = true;
          inccommand = "nosplit";
          incsearch = true;
          showmatch = false;
        };

        theme = {
          termguicolors = true;
          background = "dark";
        };
      in
      core // tabs // splits // folding // search // theme;
    plugins = {
      autoclose.enable = true;
      nix.enable = true;
      luasnip.enable = true;
      comment.enable = true;
      notify.enable = true;
      todo-comments.enable = true;
      treesitter = {
        enable = true;
        nixGrammars = true;

        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          bash
          c
          cpp
          css
          csv
          dockerfile
          haskell
          html
          javascript
          json
          lua
          lua
          make
          markdown
          nix
          proto
          python
          regex
          rust
          sql
          terraform
          toml
          typescript
          vim
          vimdoc
          xml
          yaml
        ];

        folding = true;

        settings = {
          auto_install = true;
          ensure_installed = "all";
          highlight.enable = true;
        };

      };
    };
    extraPlugins = [ ];
    extraConfigLua = ''
      vim.cmd("syntax on")

      vim.cmd([[
        let $VIMHOME = $HOME."/.config/nvim/.vim"
        set viminfo+=n$VIMHOME.".vim/viminfo"

        set foldmethod=expr
        set foldexpr=nvim_treesitter#foldexpr()
      ]])

      vim.opt.fillchars:append { diff = "╱" }

      vim.fn.sign_define("DiagnosticSignError", {
        texthl = "DiagnosticSignError",
        text = "",
        numhl = "DiagnosticSignError",
      })

      vim.fn.sign_define("DiagnosticSignWarn", {
        texthl = "DiagnosticSignWarn",
        text = "",
        numhl = "DiagnosticSignWarn",
      })

      vim.fn.sign_define("DiagnosticSignInfo", {
        texthl = "DiagnosticSignInfo",
        text = "",
        numhl = "DiagnosticSignInfo",
      })

      vim.fn.sign_define("DiagnosticSignHint", {
        texthl = "DiagnosticSignHint",
        text = "",
        numhl = "DiagnosticSignHint",
      })

      vim.diagnostic.config({
        underline = true,
        virtual_text = {
          prefix = ">",
          spacing = 2,
          source = "always", -- always | if_many
        },
        signs = true,
        update_in_insert = false,
        severity_sort = true,
      })
    '';
  };
}
