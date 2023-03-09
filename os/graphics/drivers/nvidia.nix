{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  services.logind.lidSwitch = "ignore";

  hardware.video.hidpi.enable = true;
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:7:0:0";
    sync.enable = true;
    sync.allowExternalGpu = true;
  };

  environment.variables.QT_FONT_DPI = "141";
  environment.variables.GDK_DPI_SCALE = "0.5";

  system.nixos.tags = [ "egpu" ];
}
