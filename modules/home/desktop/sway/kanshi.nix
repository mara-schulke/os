{ config, lib, ... }:

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
      }
    ];
  };
}
