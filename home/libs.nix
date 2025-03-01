{ pkgs, ... }:

{
  home.packages = with pkgs; [
    icu
    icu4c.out
  ];
}
