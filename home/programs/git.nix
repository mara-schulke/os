{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    aliases = {
      lg = "log --graph --abbrev-commit --decorate --date=format:'%Y-%m-%d %H:%I:%S' --format=format:'%C(bold blue)%h%C(reset) - %C(white)%s%C(reset) %C(dim white) - %C(dim white)%ar%C(reset) - %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      st = "status -s";
      co = "checkout";
      fa = "fetch --all --prune";
      pa = "pull --all";
      ba = "branch -v --all";
      info = "!onefetch --no-art";
    };

    userName = "Mara Schulke";
    userEmail = "mail@maras.cloud";

    lfs.enable = true;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;

      merge.tool = "nvim";
      mergetool.nvim.cmd = "nvim -c \"DiffviewOpen\"";
      mergetool.prompt = "false";
    };
  };

  home.packages = with pkgs; [
    tig
    onefetch
    lazygit
    delta
  ];
}
