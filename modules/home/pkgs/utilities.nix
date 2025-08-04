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

    lld

    python312
    python312Packages.huggingface-hub

    lsof
  ];
}
