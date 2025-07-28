# TODO!!!!!!!!!!!!!!

{ pkgs, ... }:

let
  tmux-status-theme = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "minimal";
    version = "unstable-2024-02-25";
    src = pkgs.fetchFromGitHub {
      owner = "niksingh710";
      repo = "minimal-tmux-status";
      rev = "5183698f30c521fdf890d287e3ba2f81ea4e0d1c";
      sha256 = "sha256-BrlMV4w1AsjLTjwKQXuOGRPy8QFsS4JtFtGFRUluQ50=";
    };
  };
in
{
  programs.tmux = {
    enable = false;
    sensibleOnTop = false;
    shell = "${pkgs.zsh}/bin/zsh";
    terminal = "tmux-256color";
    prefix = "C-Space";
    keyMode = "vi";
    mouse = true;
    historyLimit = 100000;
    escapeTime = 0;
    baseIndex = 1;
    disableConfirmationPrompt = true;
    plugins = [ tmux-status-theme ];
    extraConfig = ''
      # Easier reload of config
      bind r source-file ~/.config/tmux/tmux.conf
    '';
  };
}
