{ ... }:

{
  imports = [ ../../modules/home ];

  desktop.windowManager = "sway";

  home.username = "mara";
  home.homeDirectory = "/home/mara";
  home.stateVersion = "25.05";

  i3status = {
    enable = true;
    system.cpu.usage.enable = true;
    system.disk.root.enable = true;
    time.date.enable = true;
    time.clock.enable = true;
    audio.volume.enable = true;
  };
}
