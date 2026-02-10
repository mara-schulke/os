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

  gtk = {
    enable = true;
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "paperwm@paperwm.github.com"
      ];
    };
    "org/gnome/gnome-system-monitor" = {
      show-dependencies = true;
    };
    "org/gnome/system/location" = {
      enabled = true;
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
      overlay-key = "<Super>";
      dynamic-workspaces = false;
    };
    "org/gnome/desktop/wm/preferences" = {
      num-workspaces = 9; # Match workspace keybindings (1-9)
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
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Launch Alacritty";
      command = "alacritty";
      binding = "<Super>Return";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "Launch Brave";
      command = "brave";
      binding = "<Super>b";
    };

    # PaperWM Configuration
    "org/gnome/shell/extensions/paperwm" = {
      # Window spacing (matching XMonad gaps)
      horizontal-margin = 20;
      vertical-margin = 20;
      vertical-margin-bottom = 20;
      window-gap = 20;

      # Border styling (thin but bright purple)
      selection-border-size = 6;
      selection-border-radius-top = 0;
      selection-border-radius-bottom = 0;

      # Window behavior
      maximize-within-tiling = true;
      maximize-width-percent = 1.0;

      # Default settings
      default-focus-mode = 0; # DEFAULT mode (0=DEFAULT, 1=CENTER, 2=EDGE)
      open-window-position = 0; # RIGHT (0=RIGHT, 1=LEFT, 2=START, 3=END)

      # UI elements
      show-workspace-indicator = false;
      show-window-position-bar = false;
      show-focus-mode-icon = false;
      show-open-position-icon = false;
      topbar-mouse-scroll-enable = true;

      # Animation (disabled for instant window switching)
      animation-time = 0.0;

      # Minimap settings
      minimap-scale = 0.15;
      minimap-shade-opacity = 64; # 50% opacity

      # Gestures
      gesture-enabled = true;
      gesture-horizontal-fingers = 3;
      gesture-workspace-fingers = 3;

      # Drift (viewport panning) speed
      drift-speed = 4; # 4px/ms
      drag-drift-speed = 4; # 4px/ms when dragging

      # GNOME Overview settings
      overview-max-window-scale = 0.30; # 30% of actual window size
      overview-min-windows-per-row = 5;

      # Window properties (winprops)
      winprops = [
        ''{"wm_class":"Alacritty","preferredWidth":"50%"}''
      ];

      # Workspace colors (purple theme)
      workspace-colors = [
        "#b794f4" # Bright purple
        "#9f7aea" # Medium purple
        "#805ad5" # Deep purple
        "#6b46c1" # Darker purple
        "#553c9a" # Dark purple
        "#44337a" # Very dark purple
        "#b794f4" # Bright purple (repeat)
        "#9f7aea" # Medium purple (repeat)
        "#805ad5" # Deep purple (repeat)
      ];
    };

    "org/gnome/shell/extensions/paperwm/keybindings" = {
      new-window = [ ];

      # Window management (matching XMonad M-q)
      close-window = [ "<Super>q" ];

      # Window navigation (vim-style hjkl)
      switch-left = [ "<Super>h" ];
      switch-down = [ "<Super>j" ];
      switch-up = [ "<Super>k" ];
      switch-right = [ "<Super>l" ];

      # Move windows (vim-style with Shift)
      move-left = [ "<Super><Shift>h" ];
      move-down = [ "<Super><Shift>j" ];
      move-up = [ "<Super><Shift>k" ];
      move-right = [ "<Super><Shift>l" ];

      # Monitor switching (matching XMonad M-. and M-,)
      switch-monitor-right = [ "<Super>period" ];
      switch-monitor-left = [ "<Super>comma" ];

      # Move windows between monitors (with Ctrl)
      move-monitor-right = [ "<Super><Ctrl>period" ];
      move-monitor-left = [ "<Super><Ctrl>comma" ];

      # Fullscreen (matching XMonad M-f)
      toggle-maximize-width = [ "<Super>f" ];
      paper-toggle-fullscreen = [ "<Super><Shift>f" ];

      # Window cycling with wrap-around
      switch-next-loop = [ "<Alt>Tab" ];
      switch-previous-loop = [ "<Alt><Shift>Tab" ];

      # Workspace switching (disabled - using GNOME keybindings instead)
      previous-workspace = [ "<Super>Tab" ];
      previous-workspace-backward = [ "<Super><Shift>Tab" ];

      # Alt-Tab for window switching (matching XMonad Alt-Tab)
      #live-alt-tab = [ "<Alt>Tab" ];
      #live-alt-tab-backward = [ "<Alt><Shift>Tab" ];

      # Scratch layer (similar to XMonad scratchpads)
      toggle-scratch-window = [ "<Super>grave" ]; # Super+` for scratch
      toggle-scratch-layer = [ "<Super><Shift>grave" ];
      toggle-scratch = [ "<Super><Ctrl>grave" ];

      # Window sizing (alt+hjkl for directional growth)
      resize-w-inc = [
        "<Super>i"
        "<Alt>l"
      ]; # Increase width / grow right
      resize-w-dec = [
        "<Super>d"
        "<Alt>h"
      ]; # Decrease width / shrink left
      resize-h-inc = [
        "<Super><Shift>i"
        "<Alt>k"
      ]; # Increase height / grow up
      resize-h-dec = [
        "<Super><Shift>d"
        "<Alt>j"
      ]; # Decrease height / shrink down

      # Cycle window sizes
      cycle-width = [ "<Super>r" ];
      cycle-width-backwards = [ "<Super><Alt>r" ];
      cycle-height = [ "<Super><Shift>r" ];
      cycle-height-backwards = [ "<Super><Alt><Shift>r" ];

      # Center window (matching XMonad centering)
      center-horizontally = [ "<Super>c" ];

      # Window positioning
      switch-first = [
        "<Alt>1"
        "<Alt>minus"
      ];
      switch-second = [ "<Alt>2" ];
      switch-third = [ "<Alt>3" ];
      switch-fourth = [ "<Alt>4" ];
      switch-fifth = [ "<Alt>5" ];
      switch-sixth = [ "<Alt>6" ];
      switch-seventh = [ "<Alt>7" ];
      switch-eighth = [ "<Alt>8" ];
      switch-ninth = [ "<Alt>9" ];
      switch-tenth = [ "<Alt>0" ];
      switch-last = [
        "<Alt>equal"
      ];

      # Take window (useful for moving windows around)
      take-window = [ "<Super>t" ];

      # Slurp/barf (column management)
      slurp-in = [ "<Super>bracketleft" ];
      barf-out = [ "<Super>bracketright" ];
      barf-out-active = [ "<Super>o" ]; # Expel active window into its own column

      # Toggle bars
      toggle-top-and-position-bar = [ "<Super><Ctrl>b" ];

      # Workspace navigation
      switch-down-workspace = [ "<Super>Page_Down" ];
      switch-up-workspace = [ "<Super>Page_Up" ];
      move-down-workspace = [ "<Super><Ctrl>Page_Down" ];
      move-up-workspace = [ "<Super><Ctrl>Page_Up" ];

      # Drift viewport (panning)
      drift-left = [ "<Super>Left" ];
      drift-right = [ "<Super>Right" ];

      # Disable conflicting defaults
      switch-next = [ ];
      switch-previous = [ ];
    };
  };
}
