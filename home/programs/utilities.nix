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

    python312
    python312Packages.huggingface-hub

    lsof
  ];
}
