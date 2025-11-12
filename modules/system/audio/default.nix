{ pkgs, ... }:

{
  services.dbus.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.enable = true;

    extraConfig.pipewire = {
      "context.properties" = {
        "link.max-buffers" = 16;
      };
      "context.modules" = [
        {
          name = "libpipewire-module-protocol-pulse";
          args = { };
        }
      ];
    };
  };

  services.blueman.enable = true;

  environment.systemPackages = with pkgs; [
    blueman
    pavucontrol
    asha-pipewire-sink
  ];

  #boot.extraModprobeConfig = ''
  #options bluetooth enable_ecred=1
  #'';

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        LE = {
          #MinConnectionInterval = 16;
          #MaxConnectionInterval = 16;
          #ConnectionLatency = 10;
          #ConnectionSupervisionTimeout = 100;
        };
      };
    };
  };
}
