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
        algorithms
        algorithmicx
        beamer
        chemfig
        circuitikz
        draftwatermark
        fancyhdr
        geometry
        hyperref
        mathtools
        microtype
        minted
        pgfplots
        siunitx
        caption
        tikz-cd
        titlesec
        todonotes
        import
        xcolor
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
