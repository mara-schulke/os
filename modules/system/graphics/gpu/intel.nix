{ lib, config, ... }:

with lib;

let
  cfg = config.sphere.graphics.gpu.intel;
in
{
  options.sphere.graphics.gpu.intel = {
    enable = mkEnableOption "Enables intel GPU support";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "intel" ];
  };
}
