{ config, ... }:

{
  networking.wireless.enable = false;
  networking.networkmanager.enable = true;
  programs.nm-applet.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 3000 8000 8080 ];
  };

  services.openvpn.servers.work = {
    autoStart = false;
    config = '' config /etc/nixos/secrets/vpn/work/config.ovpn '';
    updateResolvConf = true;
  };
}
