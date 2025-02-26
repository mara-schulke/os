{ pkgs, ... }:

{
  imports = [
    ./editor
    ./terminal
    ./shell
    ./programs
  ];

  programs.home-manager.enable = true;

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
      permittedInsecurePackages = [ "nix-2.16.2" ];
    };
  };

  home = {
    packages = with pkgs; [
      sqlite
      sqlite.out
      tmux

      poetry
      openssl
      zlib
      perl

      (rust-bin.stable."1.84.1".default.override {
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

    stateVersion = "24.05";
    username = "mara.schulke";
    homeDirectory = "/Users/mara.schulke";
  };

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    enableJIT = true;

    ensureDatabases = [ "mara.schulke" ];
    ensureUsers = [
      {
        name = "mara.schulke";
        ensureClauses = {
          superuser = true;
        };
      }
    ];

    extraPlugins = with pkgs.postgresql16Packages; [
      pgvector
      postgis
      (timescaledb.override { postgresql = pkgs.postgresql_16; })
      (pkgs.set_user.override { postgresql = pkgs.postgresql_16; })
      (pkgs.pg_duckdb.override { postgresql = pkgs.postgresql_16; })
    ];
    settings = {
      shared_preload_libraries = "timescaledb,pg_duckdb";
    };
  };
}
