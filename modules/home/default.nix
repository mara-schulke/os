{ pkgs, ... }:

{
  imports = [
    ./env
    ./ssh.nix
    ./editor
    ./pkgs
    ./shell
    ./terminal
  ];

  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [
      sqlite
      sqlite.out
      tmux

      poetry
      openssl
      zlib
      perl

      (rust-bin.nightly."2025-08-01".default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
        targets = [ "arm-unknown-linux-gnueabihf" ];
      })

      nodejs_22
      protobuf
      nixfmt-rfc-style
    ];
  };
}
