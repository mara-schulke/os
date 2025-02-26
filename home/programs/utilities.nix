{ pkgs, ... }:

{
  home.packages = with pkgs; [
    neofetch

    ripgrep
    fd
    jq
    eza
    fzf
    bottom

    cowsay
    file
    which
    tree
    curl

    lsof
  ];
}
