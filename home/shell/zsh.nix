{ lib, ... }:

let
  tmux = false;
in
{
  programs.zsh = {
    enable = true;

    autosuggestion = {
      enable = true;
    };

    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "git-flow"
        "ssh-agent"
        "vi-mode"
      ] ++ lib.optionals tmux [ "tmux" ];
      extraConfig =
        ''
          export CASE_SENSITIVE="true"
          export DISABLE_AUTO_TITLE="true"
          export DISABLE_UNTRACKED_FILES_DIRTY="true"
          export DISABLE_MAGIC_FUNCTIONS=true

          zstyle :omz:plugins:ssh-agent identities id_ed25519
        ''
        + lib.optionalString tmux ''
          export ZSH_TMUX_AUTOSTART=false
          export ZSH_TMUX_CONFIG=$HOME/.config/tmux/conf
        '';
    };

    historySubstringSearch = {
      enable = true;
    };

    history = {
      expireDuplicatesFirst = true;
      ignoreAllDups = true;
      share = false;
    };

    syntaxHighlighting = {
      enable = true;

      styles = {
        path = "none";
        path_prefix = "none";
      };
    };

    sessionVariables = {
      # nix
      PATH = "$PATH:$HOME/.local/share/npm-global/bin";
      DARWIN_FLAKE = "$HOME/Documents/Helsing/nix";

      # xdg
      XDG_DESKTOP_DIR = "$HOME/desktop";
      XDG_DOWNLOAD_DIR = "$HOME/downloads";
      XDG_TEMPLATES_DIR = "$HOME/templates";
      XDG_PUBLICSHARE_DIR = "$HOME/workspace";
      XDG_DOCUMENTS_DIR = "$HOME/documents";
      XDG_MUSIC_DIR = "$HOME/music";
      XDG_PICTURES_DIR = "$HOME/pictures";
      XDG_VIDEOS_DIR = "$HOME/videos";

      # general
      EDITOR = "$(which nvim)";
      FZF_DEFAULT_COMMAND = "fd --type f --hidden --follow --exclude .git";
      GPG_TTY = "tty";

      # latex
      CHKTEXRC = "$HOME/.config/chktex";

      # rust
      __CARGO_TEST_CHANNEL_OVERRIDE_DO_NOT_USE_THIS = "nightly";
      CARGO_UNSTABLE_REGISTRY_AUTH = "true";

      # less
      LESSHISTFILE = "$XDG_CACHE_HOME/less/history";

      # c
      LDFLAGS = "-L/opt/homebrew/lib $LDFLAGS";
      DYLD_LIBRARY_PATH = "/opt/homebrew/lib $DYLD_LIBRARY_PATH";
    };

    shellGlobalAliases = {
      lock = "slock";
      reload = "source ~/.zshrc";
      scrot = "scrot ~/pictures/screenshots/%y%m%d-%H%M%S.png";

      # utils
      urldecode = "python3 -c \"import sys, urllib.parse as ul; print(ul.unquote(sys.argv[1]))\"";
      urlencode = "python3 -c \"import sys, urllib.parse as ul; print(ul.quote(sys.argv[1]))\"";

      # encrypted filesystems
      "mount.archive" =
        "gocryptfs -i 1h -passfile /etc/nixos/secrets/keys/archive /home/mara/workspace/writing/archive/.cryptfs $XDG_DOCUMENTS_DIR";

      # chrome
      "chromium-headless" = "chromium --kiosk --new-window";

      # dotfiles
      config = "git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
      cfg = "config";
      cst = "config status";
      ca = "config add";
      cc = "config commit";
      cco = "config checkout";
      cf = "config fetch";
      cps = "config push";

      # exa
      ls = "exa --long --all --icons --group-directories-first --git --ignore-glob '.venv' --header";
      lsd = "ls -D";
      lst = "ls -T --git-ignore -I=.git";

      # bat
      cat = "bat";

      # ag
      ag = "ag --path-to-ignore ~/.config/ag/.ignore";

      # filemanager
      fm = "nautilus";

      # neovim
      vim = "nvim";

      # nix-shell
      nix-shell = "nix-shell --command zsh";

      # nix darwin
      nix-sync = "cd $DARWIN_FLAKE && nix flake \"lock\" --update-input os && cd -";
      nix-rebuild = "nix run nix-darwin -- switch --flake $DARWIN_FLAKE#helsing";
    };

    initExtra = ''
      export PATH="/usr/local/bin:$PATH"
      export PATH="/opt/local/bin:$PATH"
      export PATH="/opt/local/sbin:$PATH"
      export PATH="/opt/homebrew/bin:$PATH"
      export PATH="$HOME/bin:$PATH"
      export PATH="$HOME/go/bin:$PATH"
      export PATH="$HOME/.cargo/bin:$PATH"
      export PATH="$HOME/.local/bin:$PATH"
      export PATH="$HOME/.config/zsh/utils:$PATH"

      # load functions
      source ${./functions/github.sh}
      source ${./functions/nix.sh}
      source ${./functions/work.sh}

      # prompt
      source ${./prompt.sh}
    '';
  };
}
