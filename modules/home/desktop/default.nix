{ lib, ... }:

{
  imports = [
    ./theme.nix
    ./gnome
    ./sway
  ];

  options.desktop.windowManager = lib.mkOption {
    type = lib.types.enum [
      "gnome"
      "sway"
      "none"
    ];
    default = "none";
    description = "Which window manager to use.";
  };

  config = {
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
  };
}
