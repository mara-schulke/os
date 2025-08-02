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
        key = "<A-,>";
        action = "<cmd>ToggleTerm size=15 direction=horizontal name=terminal<CR>";
        options.desc = "Open terminal";
        options.silent = true;
      }
      {
        key = "<A-.>";
        action = "<cmd>ToggleTerm size=75 direction=vertical<CR>";
        options.desc = "Open terminal";
        options.silent = true;
      }
    ];

    extraConfigLuaPost = ''
      require("toggleterm").setup()

      function _G.set_terminal_keymaps()
        local opts = {buffer = 0}
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
        vim.keymap.set('t', '<A-,>', [[<Cmd>ToggleTerm direction=horizontal<CR>]], opts)
        vim.keymap.set('t', '<A-.>', [[<Cmd>ToggleTerm direction=vertical<CR>]], opts)
        vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
        vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
        vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
        vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
        vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
      end

      -- if you only want these mappings for toggle term use term://*toggleterm#* instead
      vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
      vim.cmd('autocmd! TermOpen term://*toggleterm lua set_terminal_keymaps()')
    '';
  };
}
