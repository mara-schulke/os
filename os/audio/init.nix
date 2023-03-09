{ config, pkgs, ... }:

{
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio = {
    enable = true;
    daemon = {
      config = {
        enable-deferred-volume = "no";
      };
    };
    package = pkgs.pulseaudioFull; 
    #extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = ''
      load-module module-bluetooth-policy
      load-module module-bluetooth-discover
      load-module module-switch-on-connect
    '';
  };

hardware.bluetooth.settings = {
  General = {
    Enable = "Source,Sink,Media,Socket";
  };
};
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.hsphfpd.enable = true;
  hardware.bluetooth.package = pkgs.bluezFull;
}
