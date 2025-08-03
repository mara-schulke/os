{ pkgs, ... }:

let
  toggleterm = pkgs.vimUtils.buildVimPlugin {
    pname = "toggleterm";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "akinsho";
      repo = "toggleterm.nvim";
      rev = "main";
      sha256 = "sha256-fytbX+L12TK45YKFU9K+iFJcDrwboKabihc2LtX29J4=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ toggleterm ];

    keymaps = [
      {
        key = "<C-S-r>";
        action = "<cmd>luafile $MYVIMRC<cr>";
      }
      {
        key = "<A-f>";
        action = "<cmd>ToggleTerm direction=float name=scratchpad<CR>";
        options.desc = "Open scratchpad";
        options.silent = true;
      }
      {
        key = "<A-,>";
        action = "<cmd>ToggleTerm size=15 direction=horizontal name=terminal<CR>";
        options.desc = "Open terminal";
        options.silent = true;
      }
      {
        key = "<A-.>";
        action = "<cmd>ToggleTerm size=75 direction=vertical name=terminal<CR>";
        options.desc = "Open terminal";
        options.silent = true;
      }
    ];

    extraConfigLuaPost = ''
      require("toggleterm").setup()

      function _G.term_bind_keys()
        local opts = { buffer = 0 }
        vim.cmd([[ startinsert! ]], opts)
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>:]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<A-f>', [[<Cmd>ToggleTerm direction=float<CR>]], opts)
        vim.keymap.set('t', '<A-,>', [[<Cmd>ToggleTerm direction=horizontal<CR>]], opts)
        vim.keymap.set('t', '<A-.>', [[<Cmd>ToggleTerm direction=vertical<CR>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<C-l><Cmd>wincmd l<CR>]], opts)
      end

      vim.cmd('autocmd! TermOpen term://* lua term_bind_keys()')
      vim.cmd('autocmd! TermOpen term://*toggleterm lua term_bind_keys()')
      vim.cmd('autocmd! BufEnter term://* startinsert!')
      vim.cmd('autocmd! BufEnter term://*toggleterm startinsert!')
      vim.cmd('autocmd! BufWinEnter term://* startinsert!')
      vim.cmd('autocmd! BufWinEnter term://*toggleterm startinsert!')
    '';
  };
}
