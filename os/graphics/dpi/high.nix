{ config, ... }:

{
  services.xserver.dpi = 144;
  environment.variables.QT_FONT_DPI = "144";
  environment.variables.QT_AUTO_SCREEN_SET_FACTORY = "1";
  environment.variables.QT_SCALE_FACTOR = "1.5";
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1.5";
  environment.variables.WINIT_X11_SCALE_FACTOR = "1.5";
  environment.variables.XCURSOR_SIZE = "64";
  nixpkgs.config.chromium.commandLineArgs = "--force-device-scale-factor=1.75";
}
