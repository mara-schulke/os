{ pkgs, ... }:

let
  claude = pkgs.vimUtils.buildVimPlugin {
    pname = "claude-code-nvim";
    version = "1.0.0";
    src = pkgs.fetchFromGitHub {
      owner = "greggh";
      repo = "claude-code.nvim";
      rev = "main";
      sha256 = "sha256-ZEIPutxhgyaAhq+fJw1lTO781IdjTXbjKy5yKgqSLjM=";
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
