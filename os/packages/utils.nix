{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    arandr
    autorandr
    bat
    broot
    curl
    dmenu
    exa
    fd
    fzf
    httpie
    peek
    pstree
    ranger
    rclone
    ripgrep
    rofi
    scrot
    unrar
    v4l-utils
    zip unzip
    git-filter-repo
    openconnect
    openssl
  ];
}
