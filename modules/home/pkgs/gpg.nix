{ pkgs, ... }:

{
  services.gpg-agent = {
    enable = true;
    pinentry.package = pkgs.pinentry-curses;
    extraConfig = ''
      allow-loopback-pinentry
    '';
  };

  programs.gpg = {
    enable = true;
    settings.pinentry-mode = "loopback";
  };

  home.packages = with pkgs; [
    pinentry-curses
  ];
}
