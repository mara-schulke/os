{ config, lib, ... }:

let
  # FHD (1920) => 16, QHD (2560) => 32, UHD (3840) => 64
  gapForWidth = w:
    if w >= 3840 then 64
    else if w >= 2560 then 32
    else 16;

  setGaps = width: "swaymsg gaps outer all set ${toString (gapForWidth width)}";
in

lib.mkIf (config.desktop.windowManager == "sway") {
  services.kanshi = {
    enable = true;

    settings = [
      {
        profile.name = "internal";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
            scale = 1.0;
          }
        ];
        profile.exec = [ "${setGaps 1920}" ];
      }

      {
        profile.name = "home";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "disable";
          }
          {
            criteria = "Dell Inc. DELL U3225QE 5MTWF84";
            status = "enable";
            mode = "3840x2160@120.000000Hz";
            position = "0,0";
            scale = 1.0;
          }
        ];
        profile.exec = [ "${setGaps 3840}" ];
      }
    ];
  };
}
