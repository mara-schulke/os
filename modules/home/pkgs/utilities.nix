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

    mold
    lld

    python312
    python312Packages.huggingface-hub

    lsof
  ];

  home.file.".cargo/config.toml".text = ''
    [target.aarch64-apple-darwin]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=mold"]

    [target.x86_64-unknown-linux-gnu]
    linker = "clang"
    rustflags = ["-C", "link-arg=-fuse-ld=mold"]
  '';
}
