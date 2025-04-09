{ config, pkgs, fetchFromGitHub, ... }:

let
  # mozilla = import (builtins.fetchTarball https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz);
  # rust = (pkgs.rustChannelOf { date = "2025-03-18"; channel = "stable"; }).rust.override {
  #  targets = [ "wasm32-unknown-unknown" "armv7-unknown-linux-gnueabihf" "riscv32i-unknown-none-elf" ];
  #  extensions = [
  #    "rust-std"
  #    "rust-src"
  #  ];
  #};
  #unstable = import (builtins.fetchTarball https://github.com/nixos/nixpkgs/tarball/nixpkgs-unstable) {};
in {
  #nixpkgs.overlays = [(self: super: {
  #  neovim-unwrapped = super.neovim-unwrapped.overrideAttrs (_: {
  #    version = "0.11.0";
  #    src = pkgs.fetchFromGitHub {
  #      owner = "neovim";
  #      repo = "neovim";
  #      rev = "v0.11.0";
  #      sha256 = "UVMRHqyq3AP9sV79EkPUZnVkj0FpbS+XDPPOppp2yFE=";
  #    };
  #
  #    buildInputs = super.neovim-unwrapped.buildInputs ++ [ pkgs.tree-sitter ];
  #
  #   cmakeFlags = super.neovim-unwrapped.cmakeFlags ++ [ "-DUSE_BUNDLED=OFF" ];
  # });
  # })];

  environment.systemPackages = with pkgs; [
    biber
    (texlive.combine {
      inherit (texlive)
      apa
      biblatex biblatex-apa
      csquotes
      glossaries
      fontaxes
      hyphenat
      latexindent
      latexmk
      lipsum
      listing
      plex
      scheme-full
      textpos;
    }) 
    docker
    docker-compose
    flutter
    gcc
    ghc
    go
    jetbrains.clion
    jetbrains.datagrip
    jetbrains.idea-ultimate
    kubectl
    libsodium
    lens
    neovim
    nodejs
    openssl
    picocom
    python39
    # rust
    # rustup
    stack
    tig
    # unstable.terraform
    watchman
    yarn
  ];

  environment.variables.OPENSSL_DIR = "${pkgs.openssl.dev}";
  environment.variables.OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
}
