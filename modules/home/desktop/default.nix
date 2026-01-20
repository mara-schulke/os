{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnomeExtensions.paperwm
  ];

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications =
        let
          brave = "brave.desktop";
          slack = "slack.desktop";
        in
        {
          "application/pdf" = brave;
          "application/x-extension-htm" = brave;
          "application/x-extension-html" = brave;
          "application/x-extension-shtml" = brave;
          "application/x-extension-xht" = brave;
          "application/x-extension-xhtml" = brave;
          "application/xhtml+xml" = brave;
          "image/jpeg" = brave;
          "image/png" = brave;
          "text/html" = brave;
          "text/uri-list" = brave;
          "x-scheme-handler/slack" = slack;
          "x-scheme-handler/chrome" = brave;
          "x-scheme-handler/http" = brave;
          "x-scheme-handler/https" = brave;
        };
    };
    configFile."mimeapps.list".force = true;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "paperwm@paperwm.github.com"
        # "tilingshell@ferrarodomenico.com"
      ];
    };
    "org/gnome/gnome-system-monitor" = {
      show-dependencies = true;
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
  };
}
