{ pkgs, ... }:

{
  home.packages = with pkgs; [
    icu
    icu.dev
  ];
}
