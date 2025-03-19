{
  pkgs,
  ...
}:

let
  fern = pkgs.vimUtils.buildVimPlugin {
    pname = "fern";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "vim-fern";
      rev = "main";
      sha256 = "sha256-QA/Q1rlMbWJJa3IEqjhvf4/2i3RHPirwlwMtMTuKLnQ=";
    };
  };

  fern-git-status = pkgs.vimUtils.buildVimPlugin {
    pname = "fern-git-status";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "vim-fern-git-status";
      rev = "master";
      sha256 = "sha256-9N+T/MB+4hKcxoKRwY8F7iwmTsMtNmHCHiVZfcsADcc=";
    };
  };

  fern-mapping-git = pkgs.vimUtils.buildVimPlugin {
    pname = "fern-mapping-git";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "vim-fern-mapping-git";
      rev = "master";
      sha256 = "sha256-40topHOLL96FJoSD3k+umy6+8TJTEABEYZSn1/y6F9I=";
    };
  };

  fern-hijack = pkgs.vimUtils.buildVimPlugin {
    pname = "fern-hijack";
    version = "1.0";
    src = pkgs.fetchFromGitHub {
      owner = "lambdalisue";
      repo = "vim-fern-hijack";
      rev = "master";
      sha256 = "sha256-mtGg1rUif5pl/PvFUOJImHQ/Zde/Vr0VOSeDJXmkDPk=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [
      fern
      fern-git-status
      fern-mapping-git
      fern-hijack
    ];

    extraConfigLuaPost = ''
      vim.cmd([[
        let g:fern#opener = 'edit'
        let g:fern#default_hidden = 1
        let g:fern#default_exclude = '.git/**,.venv/**'
        let g:fern#drawer_width = 40
        let g:fern#disable_default_mappings = 1

        function! s:init_fern() abort
            map <buffer> <C-LeftMouse> <LeftMouse><Plug>(fern-action-open-or-expand)
            map <buffer> <C-RightMouse> <LeftMouse><Plug>(fern-action-collapse)
            map <buffer> <CR> <Plug>(fern-action-open-or-expand)
            map <buffer> l <Plug>(fern-action-open-or-expand)
            map <buffer> h <Plug>(fern-action-collapse)

            map <buffer> N <Plug>(fern-action-new-path)
            map <buffer> R <Plug>(fern-action-rename)
            map <buffer> M <Plug>(fern-action-move)
            map <buffer> D <Plug>(fern-action-remove)

            map <buffer> <leader> <Plug>(fern-action-mark:toggle)
            map <buffer> r <Plug>(fern-action-reload)
        endfunction

        augroup fern
            autocmd! *
            autocmd FileType fern setlocal signcolumn=no
            autocmd FileType fern setlocal cc=
            autocmd FileType fern setlocal nowrap
            autocmd FileType fern call s:init_fern()
        augroup END

        command! -nargs=0 FernToggle :Fern . -drawer -toggle -keep
      ]])
    '';

    keymaps = [
      {
        key = "<C-e>";
        action = ":FernToggle<CR>";
        options.desc = "Toggle Fern";
        options.silent = true;
      }
    ];
  };
}
