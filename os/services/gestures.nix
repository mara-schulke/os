{ config, pkgs, ... }:

{
  systemd.user.services.gestures = {
    description = "Gesture support";
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    wantedBy = [ "graphical-session.target" ];

    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.libinput-gestures}/bin/libinput-gestures";
      RestartSec = 3;
      Restart = "always";
    };

    path = with pkgs; [ wmctrl ];
  };
}
