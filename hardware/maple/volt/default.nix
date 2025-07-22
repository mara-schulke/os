{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.maple.volt;

  kfrgb = pkgs.writeShellApplication {
    name = "kfrgb";
    runtimeInputs = with pkgs; [
      busybox
      yad
      i2c-tools
      lshw
      perl
      bash
    ];
    text = ''
      set +ue
      rmmod spd5118
      set -e
      ${builtins.readFile ./kfrgb.sh}
      set +e
      modprobe spd5118
    '';
    checkPhase = "";
  };

  volt = pkgs.writeShellApplication {
    name = "volt";
    runtimeInputs = with pkgs; [
      liquidctl
      kfrgb
    ];
    text = ''
      ${kfrgb}/bin/kfrgb --mode static --smbus 1 --ramslots 2,4 --color 255,200,255 --brightness 100 --iwanttoriskandskipmodeldetectionevenifiknowthisisstronglynotrecommended --nowarn
      liquidctl set sync color static ffbbbb
    '';
  };
in
{
  options.maple.volt = {
    enable = mkEnableOption "Enables volt";
  };

  config = mkIf cfg.enable {
    boot.kernelModules = [
      "i2c-core"
      "i2c-dev"
      "i2c-piix4"
    ];

    boot.kernelParams = [
      "acpi_enforce_resources=lax"
    ];

    boot.initrd.kernelModules = [
      "i2c-core"
      "i2c-dev"
      "i2c-piix4"
    ];

    systemd.services.volt = {
      enable = true;
      description = "Volt";
      wantedBy = [ "basic.target" ];
      path = [ volt ];
      serviceConfig = {
        User = "root";
        ExecStart = "${volt}/bin/volt";
        Type = "oneshot";
      };
    };

    environment.systemPackages = [
      volt
      kfrgb
    ];
  };
}
