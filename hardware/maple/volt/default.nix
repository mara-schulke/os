{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.maple.volt;

  kfrgb = writeShellApplication {
    name = "kfrgb";
    runtimeInputs = with pkgs; [
      yad
      i2c-tools
      lshw
      bash
    ];
    text = ./kfrgb.sh;
  };

  volt = writeShellApplication {
    name = "volt";
    runtimeInputs = with pkgs; [
      liquidctl
      kfrgb
    ];
    text = ''
      kfrgb \
        --smbus 1 \
        --ramslots 2,4 \
        --color 255,200,255 \
        --brightness 100 \
        --mode static \
        --iwanttoriskandskipmodeldetectionevenifiknowthisisstronglynotrecommended \
        --nowarn
      liquidctl set sync color static ffbbbb
    '';
  };
in
{
  options.maple.volt = {
    enable = mkEnableOption "Enables volt";
  };

  config = mkIf cfg.enable {
    systemd.user.services.volt = {
      enable = true;
      description = "Volt";
      before = [ "basic.target" ];
      wantedBy = [ "basic.target" ];
      after = [
        "local-fs.target"
        "sysinit.target"
      ];
      path = [ volt ];
      serviceConfig = {
        User = "root";
        ExecStart = "${volt}/bin/volt";
        Type = "oneshot";
      };
    };
  };
}
