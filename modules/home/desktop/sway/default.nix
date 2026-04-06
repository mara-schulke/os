{
  pkgs,
  config,
  lib,
  inputs,
  ...
}:

let
  colorScheme = config.colorScheme.palette;
  nixColorsLib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in
{
  imports = [ ./i3status.nix ];
}
// lib.mkIf (config.desktop.windowManager == "sway") {
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
        default_border pixel 2
        default_floating_border pixel 2
      '';

      config =
        let
          modifier = "Mod4";
        in
        {
          inherit modifier;

          terminal = "alacritty";
          defaultWorkspace = "workspace number 1";

          startup = [
            { command = "alacritty --command ssh-add"; }
            {
              command = ''
                swayidle -w \
                  timeout 600 'swaylock -f' \
                  timeout 610 'swaymsg "output * power off"' \
                  resume 'swaymsg "output * power on"' \
                  before-sleep 'swaylock -f'
              '';
            }
          ];

          keybindings = lib.mkOptionDefault {
            "${modifier}+Escape" = "exec swaylock";
            "${modifier}+Shift+s" = "exec grim -g \"$(slurp)\" - | wl-copy";
            "${modifier}+d" =
              "exec dmenu-wl_run -m $(swaymsg -t get_outputs | jq -r 'map(.focused) | index(true)') -fn '${config.fonts.systemFont.main.name}' -nb '#${colorScheme.base00}' -nf '#${colorScheme.base07}' -sb '#${colorScheme.base0B}' -sf '#${colorScheme.base00}'";
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
              bg = "#${colorScheme.base00} solid_color";
            };
          };

          gaps = {
            smartBorders = "on";
            smartGaps = true;
            inner = 16;
          };

          colors = {
            background = "#${colorScheme.base00}";

            focused = {
              background = "#${colorScheme.base0B}";
              border = "#${colorScheme.base0B}";
              childBorder = "#${colorScheme.base0B}";
              indicator = "#${colorScheme.base08}";
              text = "#${colorScheme.base00}";
            };

            focusedInactive = {
              background = "#${colorScheme.base03}";
              border = "#${colorScheme.base03}";
              childBorder = "#${colorScheme.base03}";
              indicator = "#${colorScheme.base08}";
              text = "#${colorScheme.base07}";
            };

            placeholder = {
              background = "#${colorScheme.base03}";
              border = "#${colorScheme.base03}";
              childBorder = "#${colorScheme.base03}";
              indicator = "#${colorScheme.base08}";
              text = "#${colorScheme.base07}";
            };

            unfocused = {
              background = "#${colorScheme.base03}";
              border = "#${colorScheme.base03}";
              childBorder = "#${colorScheme.base03}";
              indicator = "#${colorScheme.base08}";
              text = "#${colorScheme.base07}";
            };

            urgent = {
              background = "#${colorScheme.base08}";
              border = "#${colorScheme.base08}";
              childBorder = "#${colorScheme.base08}";
              indicator = "#${colorScheme.base0A}";
              text = "#${colorScheme.base07}";
            };
          };

          bars = [
            {
              statusCommand = "${pkgs.i3status}/bin/i3status";
              position = "top";

              trayOutput = "none";

              fonts = {
                names = [ "${config.fonts.systemFont.main.name}" ];
                style = "Regular";
                size = config.fonts.systemFont.main.size-small * 1.0;
              };

              colors = {
                background = "#${colorScheme.base00}";
                focusedBackground = "#${colorScheme.base00}";

                focusedStatusline = "#${colorScheme.base07}";
                statusline = "#${colorScheme.base07}";

                focusedSeparator = "#${colorScheme.base07}";
                separator = "#${colorScheme.base07}";

                urgentWorkspace = {
                  background = "#${colorScheme.base08}";
                  border = "#${colorScheme.base08}";
                  text = "#${colorScheme.base00}";
                };

                focusedWorkspace = {
                  background = "#${colorScheme.base0B}";
                  border = "#${colorScheme.base0B}";
                  text = "#${colorScheme.base00}";
                };

                activeWorkspace = {
                  background = "#${colorScheme.base00}";
                  border = "#${colorScheme.base00}";
                  text = "#${colorScheme.base07}";
                };

                inactiveWorkspace = {
                  background = "#${colorScheme.base00}";
                  border = "#${colorScheme.base00}";
                  text = "#${colorScheme.base07}";
                };

                bindingMode = {
                  background = "#${colorScheme.base00}";
                  border = "#${colorScheme.base00}";
                  text = "#${colorScheme.base07}";
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
      font = "${config.fonts.systemFont.main.name} ${toString config.fonts.systemFont.main.size-small}";
      border-color = "#${colorScheme.base07}";
      background-color = "#${colorScheme.base00}";
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
      inside-clear-color = "${colorScheme.base07}";
      inside-ver-color = "${colorScheme.base0D}";
      inside-wrong-color = "${colorScheme.base08}";
      separator-color = "${colorScheme.base07}";
      ring-color = "${colorScheme.base07}";
      text-color = "${colorScheme.base07}";
      key-hl-color = "${colorScheme.base0B}";
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
}
