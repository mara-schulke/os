{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  colorScheme = config.colorScheme.palette;
  nixColorsLib = inputs.colors.lib.contrib { inherit pkgs; };

  ws1 = "1:terminal";
  ws2 = "2:editor";
  ws3 = "3:browser";
  ws4 = "4:database";
  ws5 = "5:ssh";
  ws6 = "6:server";
  ws7 = "7:other";
  ws8 = "8:messages";
  ws9 = "9:config";
  ws0 = "10:misc";
in
{
  imports = [ ./i3status.nix ];
}
// (lib.mkIf (config.desktop.windowManager == "sway") {
  home.packages = with pkgs; [
    swayidle
    wl-clipboard
    wlr-randr
    grim
    slurp
    mako
    i3status
    dmenu-wayland
    jq
    swaylock
    brightnessctl
    pamixer
    playerctl
  ];

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    XDG_CURRENT_DESKTOP = "sway";
    XDG_SESSION_TYPE = "wayland";
    NIXOS_OZONE_WL = "1";
  };

  wayland = {
    windowManager.sway = {
      enable = true;
      checkConfig = true;
      systemd.enable = true;

      wrapperFeatures = {
        gtk = true;
      };

      extraConfig = ''
        default_border pixel 1
        default_floating_border pixel 1
        workspace_auto_back_and_forth yes
        assign [app_id="brave-browser"] workspace ${ws3}
        assign [class="Brave-browser"] workspace ${ws3}
        assign [app_id="Slack"] workspace ${ws8}
        assign [class="Slack"] workspace ${ws8}
        assign [app_id="1password"] workspace ${ws0}
        assign [class="1Password"] workspace ${ws0}
      '';

      config =
        let
          modifier = "Mod4";
        in
        {
          inherit modifier;

          terminal = "alacritty";
          defaultWorkspace = "workspace ${ws1}";

          startup = [
            {
              command = "swaymsg 'workspace ${ws1}; workspace ${ws2}; workspace ${ws3}; workspace ${ws4}; workspace ${ws5}; workspace ${ws6}; workspace ${ws7}; workspace ${ws8}; workspace ${ws9}; workspace ${ws0}; workspace ${ws1}'";
            }
            { command = "alacritty"; }
            { command = "brave"; }
            { command = "1password"; }
            { command = "slack"; }
            {
              # timeout 600 'swaylock -f' \
              # before-sleep 'swaylock -f'
              command = ''
                swayidle -w \
                  timeout 610 'swaymsg "output * power off"' \
                  resume 'swaymsg "output * power on"'
              '';
            }
          ];

          keybindings = lib.mkOptionDefault {
            # App launcher (M-Space like XMonad)
            "${modifier}+space" =
              "exec dmenu-wl_run -fn '${config.fonts.systemFont.main.name}' -nb '#${colorScheme.base00}' -nf '#${colorScheme.base05}' -sb '#${colorScheme.base0E}' -sf '#${colorScheme.base00}'";

            # Core applications
            "${modifier}+b" = "exec brave";
            # TODO: "Mod1+l" = "exec swaylock";
            "${modifier}+Escape" = "exec swaylock";

            # Kill window (M-q like XMonad)
            "${modifier}+q" = "kill";

            # Gaps (M-d/M-i/M-g like XMonad)
            "${modifier}+d" = "gaps inner current minus 16";
            "${modifier}+i" = "gaps inner current plus 16";
            "${modifier}+g" = "gaps inner current toggle 16";
            "${modifier}+Shift+g" = "gaps inner current toggle 240";

            # Floating (M-t like XMonad)
            "${modifier}+t" = "floating toggle";

            # Workspace / layout cycling
            "${modifier}+Tab" = "workspace back_and_forth";
            "${modifier}+Shift+Tab" = "layout toggle split tabbed stacking";

            # Multi-monitor (M-. / M-, like XMonad)
            "${modifier}+period" = "focus output right";
            "${modifier}+comma" = "focus output left";
            "${modifier}+Shift+period" = "move container to output right";
            "${modifier}+Shift+comma" = "move container to output left";

            # Focus parent (M-m like XMonad focus master)
            "${modifier}+m" = "focus parent";

            # Screenshot
            "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
            "${modifier}+Print" = "exec grim -g \"$(slurp)\" - | wl-copy";

            # Media keys
            "XF86AudioRaiseVolume" = "exec pamixer -i 10";
            "XF86AudioLowerVolume" = "exec pamixer -d 10";
            "XF86AudioMute" = "exec pamixer -t";
            "XF86AudioMicMute" = "exec pamixer --default-source -t";
            "XF86MonBrightnessUp" = "exec brightnessctl set +10%";
            "XF86MonBrightnessDown" = "exec brightnessctl set 10%-";
            "XF86AudioPlay" = "exec playerctl play-pause";
            "XF86AudioNext" = "exec playerctl next";
            "XF86AudioPrev" = "exec playerctl previous";

            # Named workspaces (matching XMonad workspace names)
            "${modifier}+1" = "workspace ${ws1}";
            "${modifier}+2" = "workspace ${ws2}";
            "${modifier}+3" = "workspace ${ws3}";
            "${modifier}+4" = "workspace ${ws4}";
            "${modifier}+5" = "workspace ${ws5}";
            "${modifier}+6" = "workspace ${ws6}";
            "${modifier}+7" = "workspace ${ws7}";
            "${modifier}+8" = "workspace ${ws8}";
            "${modifier}+9" = "workspace ${ws9}";
            "${modifier}+0" = "workspace ${ws0}";

            "${modifier}+Shift+1" = "move container to workspace ${ws1}";
            "${modifier}+Shift+2" = "move container to workspace ${ws2}";
            "${modifier}+Shift+3" = "move container to workspace ${ws3}";
            "${modifier}+Shift+4" = "move container to workspace ${ws4}";
            "${modifier}+Shift+5" = "move container to workspace ${ws5}";
            "${modifier}+Shift+6" = "move container to workspace ${ws6}";
            "${modifier}+Shift+7" = "move container to workspace ${ws7}";
            "${modifier}+Shift+8" = "move container to workspace ${ws8}";
            "${modifier}+Shift+9" = "move container to workspace ${ws9}";
            "${modifier}+Shift+0" = "move container to workspace ${ws0}";
          };

          fonts = {
            names = [ "${config.fonts.systemFont.main.name}" ];
            style = "Regular";
            size = config.fonts.systemFont.main.size-small * 1.0;
          };

          input = {
            "*" = {
              pointer_accel = "1";
              accel_profile = "flat";
            };
          };

          output = {
            "*" = {
              bg =
                if config.desktop.wallpaper != null then
                  "${config.desktop.wallpaper} fill"
                else
                  "#${colorScheme.base00} solid_color";
            };
          };

          gaps = {
            smartBorders = "off";
            smartGaps = false;
            inner = 0;
          };

          colors = {
            background = "#${colorScheme.base00}";

            focused = {
              background = "#${colorScheme.base0E}";
              border = "#${colorScheme.base0E}";
              childBorder = "#${colorScheme.base0E}";
              indicator = "#${colorScheme.base0D}";
              text = "#${colorScheme.base00}";
            };

            focusedInactive = {
              background = "#${colorScheme.base01}";
              border = "#${colorScheme.base01}";
              childBorder = "#${colorScheme.base01}";
              indicator = "#${colorScheme.base03}";
              text = "#${colorScheme.base05}";
            };

            placeholder = {
              background = "#${colorScheme.base01}";
              border = "#${colorScheme.base01}";
              childBorder = "#${colorScheme.base01}";
              indicator = "#${colorScheme.base03}";
              text = "#${colorScheme.base05}";
            };

            unfocused = {
              background = "#${colorScheme.base01}";
              border = "#${colorScheme.base01}";
              childBorder = "#${colorScheme.base01}";
              indicator = "#${colorScheme.base03}";
              text = "#${colorScheme.base05}";
            };

            urgent = {
              background = "#${colorScheme.base08}";
              border = "#${colorScheme.base08}";
              childBorder = "#${colorScheme.base08}";
              indicator = "#${colorScheme.base09}";
              text = "#${colorScheme.base07}";
            };
          };

          bars = [
            {
              statusCommand = "${pkgs.i3status}/bin/i3status";
              position = "top";
              trayOutput = "none";

              extraConfig = ''
                strip_workspace_numbers no
                separator_symbol " :: "
              '';

              fonts = {
                names = [ "${config.fonts.systemFont.main.name}" ];
                style = "Regular";
                size = config.fonts.systemFont.main.size-small * 1.0;
              };

              colors = {
                background = "#${colorScheme.base00}";
                focusedBackground = "#${colorScheme.base00}";

                focusedStatusline = "#${colorScheme.base05}";
                statusline = "#${colorScheme.base04}";

                focusedSeparator = "#${colorScheme.base03}";
                separator = "#${colorScheme.base03}";

                urgentWorkspace = {
                  background = "#${colorScheme.base08}";
                  border = "#${colorScheme.base08}";
                  text = "#${colorScheme.base00}";
                };

                focusedWorkspace = {
                  background = "#${colorScheme.base0E}";
                  border = "#${colorScheme.base0E}";
                  text = "#${colorScheme.base00}";
                };

                activeWorkspace = {
                  background = "#${colorScheme.base01}";
                  border = "#${colorScheme.base01}";
                  text = "#${colorScheme.base05}";
                };

                inactiveWorkspace = {
                  background = "#${colorScheme.base00}";
                  border = "#${colorScheme.base00}";
                  text = "#${colorScheme.base04}";
                };

                bindingMode = {
                  background = "#${colorScheme.base0E}";
                  border = "#${colorScheme.base0E}";
                  text = "#${colorScheme.base00}";
                };
              };
            }
          ];
        };
    };
  };

  services.mako = {
    enable = true;
    settings = {
      default-timeout = 5000;
      font = "${config.fonts.systemFont.main.name} ${
        toString (config.fonts.systemFont.main.size-small * 0.75)
      }";
      border-color = "#${colorScheme.base0E}";
      background-color = "#${colorScheme.base00}";
      text-color = "#${colorScheme.base05}";
      padding = 10;
    };
  };

  programs.swaylock = {
    enable = true;
    settings = {
      font = "${config.fonts.systemFont.main.name}";
      size = config.fonts.systemFont.main.size-small;
      color = "${colorScheme.base00}";
      inside-color = "${colorScheme.base00}";
      inside-clear-color = "${colorScheme.base05}";
      inside-ver-color = "${colorScheme.base0D}";
      inside-wrong-color = "${colorScheme.base08}";
      separator-color = "${colorScheme.base0E}";
      ring-color = "${colorScheme.base0E}";
      text-color = "${colorScheme.base05}";
      key-hl-color = "${colorScheme.base0E}";
      bs-hl-color = "${colorScheme.base08}";
      line-uses-inside = true;
      image = "${nixColorsLib.nixWallpaperFromScheme {
        scheme = config.colorScheme;
        width = 3840;
        height = 2160;
        logoScale = 6.0;
      }}";
      scaling = "fill";
    };
  };
})
