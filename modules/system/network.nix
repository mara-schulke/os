{ lib, ... }:

{
  services.sunshine = {
    enable = true;
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };

  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts =
      let
        general = [
          22
          80
          443
          3000
          8000
          8080
        ];

        sunshine = [
          47984
          47989
          47990
          48010
        ];
      in
      general ++ sunshine;

    allowedUDPPortRanges =
      let
        sunshine = [
          {
            from = 47998;
            to = 48000;
          }
          {
            from = 8000;
            to = 8010;
          }
        ];
      in
      sunshine;
  };

}
