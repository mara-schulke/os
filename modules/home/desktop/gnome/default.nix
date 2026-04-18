{
  pkgs,
  config,
  lib,
  ...
}:

lib.mkIf (config.desktop.windowManager == "gnome") {
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [ ];
    };
    "org/gnome/gnome-system-monitor" = {
      show-dependencies = true;
    };
    "org/gnome/system/location" = {
      enabled = true;
    };
    "org/gnome/desktop/background" = lib.mkIf (config.desktop.wallpaper != null) {
      picture-uri = "file://${config.desktop.wallpaper}";
      picture-uri-dark = "file://${config.desktop.wallpaper}";
      picture-options = "zoom";
    };
    "org/gnome/desktop/interface" = {
      enable-animations = false;
    };
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super>1" ];
      switch-to-workspace-2 = [ "<Super>2" ];
      switch-to-workspace-3 = [ "<Super>3" ];
      switch-to-workspace-4 = [ "<Super>4" ];
      switch-to-workspace-5 = [ "<Super>5" ];
      switch-to-workspace-6 = [ "<Super>6" ];
      switch-to-workspace-7 = [ "<Super>7" ];
      switch-to-workspace-8 = [ "<Super>8" ];
      switch-to-workspace-9 = [ "<Super>9" ];
      move-to-workspace-1 = [ "<Super><Shift>1" ];
      move-to-workspace-2 = [ "<Super><Shift>2" ];
      move-to-workspace-3 = [ "<Super><Shift>3" ];
      move-to-workspace-4 = [ "<Super><Shift>4" ];
      move-to-workspace-5 = [ "<Super><Shift>5" ];
      move-to-workspace-6 = [ "<Super><Shift>6" ];
      move-to-workspace-7 = [ "<Super><Shift>7" ];
      move-to-workspace-8 = [ "<Super><Shift>8" ];
      move-to-workspace-9 = [ "<Super><Shift>9" ];
    };
    "org/gnome/mutter" = {
      # overlay-key = "";
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 9; # match workspace keybindings (1-9)
    };
    "org/gnome/shell/keybindings" = {
      toggle-overview = [ "<Super>" ];
      switch-to-application-1 = [ ];
      switch-to-application-2 = [ ];
      switch-to-application-3 = [ ];
      switch-to-application-4 = [ ];
      switch-to-application-5 = [ ];
      switch-to-application-6 = [ ];
      switch-to-application-7 = [ ];
      switch-to-application-8 = [ ];
      switch-to-application-9 = [ ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/900"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/910"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/900" = {
      name = "Launch Alacritty";
      command = "${pkgs.alacritty}/bin/alacritty";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/910" = {
      name = "Launch Brave";
      command = "${pkgs.brave}/bin/brave";
      binding = "<Super>b";
    };

  };
}
