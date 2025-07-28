{ config, pkgs, ... }:

{
  boot.loader.efi.canTouchEfiVariables = true;
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [
      config.boot.kernelPackages.v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 video_nr=9
    '';
  };
}
