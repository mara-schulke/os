{ pkgs, inputs, ... }:

{
  imports = [
    inputs.claude.homeModules.default

    ./env
    ./ssh.nix
    ./editor
    ./pkgs
    ./shell
    ./terminal
    ./desktop
  ];

  programs.home-manager.enable = true;
  programs.claude = {
    enable = true;
    settings = {
      model = "sonnet[1m]";
      effortLevel = "medium";
    };
  };

  home.packages = with pkgs; [
    sqlite
    sqlite.out
    tmux

    gh
    glab
    jj

    poetry
    openssl
    zlib
    perl

    (rust-bin.stable.latest.default.override {
      extensions = [
        "rust-src"
        "rust-analyzer"
      ];
      targets = [ "arm-unknown-linux-gnueabihf" ];
    })

    protobuf
    nixfmt
  ];
}
