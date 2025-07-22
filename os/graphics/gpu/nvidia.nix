{
  lib,
  config,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.sphere.graphics.gpu.nvidia;
in
{
  options.sphere.graphics.gpu.nvidia = {
    enable = mkEnableOption "Enables nvidia GPU support";
  };

  config = mkIf cfg.enable {
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [ nvidia-vaapi-driver ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
  };
}
