{ pkgs, ... }:

{
  home.packages = with pkgs; [
    setzer
    sqlitebrowser
  ];
}
