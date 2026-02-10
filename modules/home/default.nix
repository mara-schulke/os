{ pkgs, ... }:

{
  imports = [
    ./env
    ./ssh.nix
    ./editor
    ./pkgs
    ./shell
    ./terminal
    ./desktop
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

      (rust-bin.stable.latest.default.override {
        extensions = [
          "rust-src"
          "rust-analyzer"
        ];
        targets = [ "arm-unknown-linux-gnueabihf" ];
      })

      protobuf
      nixfmt-rfc-style
    ];
  };
}
