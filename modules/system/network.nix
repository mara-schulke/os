{ lib, ... }:

{
  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      22
      80
      443
      3000
      8000
      8080
    ];
  };
}
