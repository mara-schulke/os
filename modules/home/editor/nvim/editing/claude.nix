{ pkgs, ... }:

let
  claude = pkgs.vimUtils.buildVimPlugin {
    pname = "claude-code-nvim";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "greggh";
      repo = "claude-code.nvim";
      rev = "main";
      sha256 = "sha256-HBHlP2k4vUCbE+Sgm6vN5XE7UGnioFvj8CI6h5H+8x8=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ claude ];

    extraConfigLuaPost = ''
      require('claude-code').setup()
    '';

    keymaps = [
      {
        key = "<A-h>";
        action = "<cmd>ClaudeCode<CR>";
        options.desc = "Open claude";
        options.silent = true;
      }
    ];
  };
}
