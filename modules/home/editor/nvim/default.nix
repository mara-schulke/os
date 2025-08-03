{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

    ./colorscheme
    ./editing
    ./filepicker
    ./greeter
    ./lsp
    ./misc
    ./parser
    ./statusline
    ./terminal
    ./utils
    ./vcs
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
          compatible = false;
          conceallevel = 0; # so that `` is visible in markdown files
          cursorcolumn = true;
          cursorline = true; # highlight the current line
          fileencoding = "utf-8"; # the encoding written to a file
          filetype = null;
          hidden = true; # required to keep multiple buffers and open multiple buffers
          hlsearch = true; # highlight all matches on previous search pattern
          ignorecase = true; # ignore case in search patterns
          laststatus = 2;
          list = true;
          listchars = "tab:➞\\t,extends:›,precedes:‹,nbsp:·,trail:·,space:·";
          mouse = "a";
          number = true; # set numbered lines
          pumheight = 10; # pop up menu height
          relativenumber = true; # set relative numbered lines
          scrolloff = 8;
          showmode = false;
          sidescrolloff = 8;
          signcolumn = "yes"; # always show the sign column otherwise it would shift the text each time
          smartcase = true; # smart case
          spell = false;
          spelllang = "en";
          swapfile = false; # creates a swapfile
          title = true; # set the title of window to the value of the titlestring
          titlestring = "nvim :: %f"; # what the title of the window will be set to
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
      core // tabs // splits // search // theme;
    plugins = {
      autoclose.enable = true;
      nix.enable = true;
      luasnip.enable = true;
      comment.enable = true;
      notify.enable = true;
      todo-comments.enable = true;
    };
    extraPlugins = [ ];
    extraConfigLua = ''
      vim.cmd([[
        let $VIMHOME = $HOME."/.config/nvim/.vim"
        set viminfo+=n$VIMHOME.".vim/viminfo"
      ]])

      vim.opt.fillchars:append { diff = "╱" }
    '';
  };
}
