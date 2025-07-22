{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    arandr
    autorandr
    bat
    broot
    curl
    dmenu
    fd
    fzf
    httpie
    peek
    pstree
    ranger
    rclone
    ripgrep
    rofi
    gwe
    scrot
    unrar
    v4l-utils
    zip
    unzip
    git-filter-repo
    openconnect
    openssl
  ];
}
