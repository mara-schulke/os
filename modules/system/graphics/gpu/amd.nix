{ lib, config, ... }:

with lib;

let
  cfg = config.sphere.graphics.gpu.amd;
in
{
  options.sphere.graphics.gpu.amd = {
    enable = mkEnableOption "Enables amd GPU support";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "amd" ];
  };
}
