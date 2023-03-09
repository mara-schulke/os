{ config, ... }:

{
  services.xserver.dpi = 96;
  environment.variables.QT_FONT_DPI = "96";
  environment.variables.QT_AUTO_SCREEN_SCALE_FACTOR = "0";
  environment.variables.QT_SCREEN_SCALE_FACTORS = "1";
  environment.variables.GDK_SCALE = "1";
  environment.variables.GDK_DPI_SCALE = "1";
  environment.variables.WINIT_X11_SCALE_FACTOR = "1.5";
}
