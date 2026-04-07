{
  lib,
  config,
  ...
}:

with lib;
let
  cfg = config.i3status;
in
{
  options.i3status = {
    enable = (mkEnableOption "i3status bar") // { default = true; };

    system = {
      cpu = {
        temperature.enable = mkEnableOption "CPU temperature display";
        usage.enable = (mkEnableOption "CPU usage display") // { default = true; };
      };

      memory = {
        enable = (mkEnableOption "memory usage display") // { default = true; };
      };

      disk = {
        root.enable = (mkEnableOption "root filesystem usage display") // { default = true; };
      };
    };

    time = {
      date.enable = (mkEnableOption "date display") // { default = true; };
      clock.enable = (mkEnableOption "time display") // { default = true; };
    };

    audio = {
      volume.enable = (mkEnableOption "volume display") // { default = true; };
    };

    power = {
      battery = {
        enable = (mkEnableOption "battery status display") // { default = true; };
        path = mkOption {
          type = types.str;
          default = "/sys/class/power_supply/BAT0/uevent";
          description = "Path to battery information";
        };
        lowThreshold = mkOption {
          type = types.int;
          default = 20;
          description = "Low battery threshold percentage";
        };
      };
    };

    network = {
      wireless = {
        enable = mkEnableOption "wireless network display";
        interface = mkOption {
          type = types.str;
          default = "wlp2s0";
          description = "Wireless interface name";
        };
      };

      ethernet = {
        enable = mkEnableOption "ethernet network display";
        interface = mkOption {
          type = types.str;
          default = "enp1s0f0";
          description = "Ethernet interface name";
        };
      };
    };

    colors = {
      good = mkOption {
        type = types.str;
        default = assert config.colorScheme.palette ? base0E; config.colorScheme.palette.base0E;
        description = "Color for good status";
      };

      degraded = mkOption {
        type = types.str;
        default = assert config.colorScheme.palette ? base0D; config.colorScheme.palette.base0D;
        description = "Color for degraded status";
      };

      bad = mkOption {
        type = types.str;
        default = assert config.colorScheme.palette ? base0E; config.colorScheme.palette.base0E;
        description = "Color for bad status";
      };
    };

    interval = mkOption {
      type = types.int;
      default = 5;
      description = "Update interval in seconds";
    };
  };

  config = mkIf cfg.enable {
    programs.i3status = {
      enable = true;
      enableDefault = false;

      general = {
        colors = true;
        color_good = "#${cfg.colors.good}";
        color_degraded = "#${cfg.colors.degraded}";
        color_bad = "#${cfg.colors.bad}";
        interval = cfg.interval;
      };

      modules = mkMerge [
        (mkIf cfg.system.cpu.temperature.enable {
          "cpu_temperature 0" = {
            position = 1;
            settings.format = "%degrees°C";
          };
        })

        (mkIf cfg.system.cpu.usage.enable {
          "cpu_usage" = {
            position = 2;
            settings.format = "cpu %usage";
          };
        })

        (mkIf cfg.system.memory.enable {
          "memory" = {
            position = 3;
            settings = {
              format = "mem %used";
              threshold_degraded = "10%";
              threshold_critical = "5%";
            };
          };
        })

        (mkIf cfg.system.disk.root.enable {
          "disk /" = {
            position = 4;
            settings.format = "disk %free";
          };
        })

        (mkIf cfg.network.wireless.enable {
          "wireless ${cfg.network.wireless.interface}" = {
            position = 5;
            settings = {
              format_up = "%essid %quality";
              format_down = "";
            };
          };
        })

        (mkIf cfg.network.ethernet.enable {
          "ethernet ${cfg.network.ethernet.interface}" = {
            position = 6;
            settings = {
              format_up = "eth %ip";
              format_down = "";
            };
          };
        })

        (mkIf cfg.audio.volume.enable {
          "volume master" = {
            position = 7;
            settings = {
              format = "vol %volume";
              format_muted = "vol muted";
              device = "default";
              mixer = "Master";
              mixer_idx = 0;
            };
          };
        })

        (mkIf cfg.power.battery.enable {
          "battery 0" = {
            position = 8;
            settings = {
              format = "bat %percentage %remaining";
              format_down = "";
              last_full_capacity = true;
              integer_battery_capacity = true;
              low_threshold = cfg.power.battery.lowThreshold;
              threshold_type = "percentage";
              hide_seconds = true;
              path = cfg.power.battery.path;
            };
          };
        })

        (mkIf cfg.time.date.enable {
          "tztime date" = {
            position = 9;
            settings.format = "%Y-%m-%d";
          };
        })

        (mkIf cfg.time.clock.enable {
          "tztime local2" = {
            position = 10;
            settings.format = "%H:%M";
          };
        })
      ];
    };
  };
}
