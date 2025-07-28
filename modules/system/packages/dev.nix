{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    biber
    (texlive.combine {
      inherit (texlive)
        apa
        biblatex
        biblatex-apa
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
        textpos
        ;
    })
    curl
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
    lens
    libsodium
    liquidctl
    neovim
    neovim
    nodejs
    openssl
    picocom
    python3
    resources
    stack
    tig
    watchman
    yarn
  ];

  programs.zsh.enable = true;

  environment.variables.OPENSSL_DIR = "${pkgs.openssl.dev}";
  environment.variables.OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
}
