{ lib, pkgs, ... }:

let
  opSign =
    if pkgs.stdenv.isDarwin then
      "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
    else if pkgs.stdenv.isLinux then
      "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}"
    else
      builtins.throw "Unsupported system target for 1password commit signing";
in
{
  home.packages = with pkgs; [
    claude-code
    zed-editor
    tig
    onefetch
    lazygit
    delta
  ];

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
    signing.signByDefault = true;

    extraConfig = {
      init.defaultBranch = "main";
      push.autoSetupRemote = true;

      merge.tool = "nvim";
      mergetool.nvim.cmd = "nvim -c \"DiffviewOpen\"";
      mergetool.prompt = "false";

      credentials.helper = "store";

      gpg.format = "ssh";
      "gpg \"ssh\"".program = opSign;

      commit.gpgsign = true;
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQzqzXz57EF6Z9anpzFhK4a1LscLC+e4W4IWiuJ0d5G";
    };
  };
}
