{ pkgs, lib, ... }:

{
  home.packages =
    with pkgs;
    [
      sqlitebrowser
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [
      setzer
    ];
}
