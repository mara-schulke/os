{ pkgs, ... }:

let
  serverPublic = "e1mrLtHovfDiBP9442k43HfEjFUJ6Vik+DZ2Zv7EaGE=";
  serverHost = "vpn.maras.cloud";
  serverPort = "51820";
in
{
  networking.wireguard.interfaces = {
    wg0 = {
      ips = [ "10.100.0.2/24" ];

      listenPort = 51820;

      privateKeyFile = "/root/wireguard/keys/private";

      peers = [
        {
          publicKey = serverPublic;

          endpoint = "${serverHost}:${serverPort}";

          allowedIPs = [
            "0.0.0.0/0"
            "::/0"
          ];

          persistentKeepalive = 25;
        }
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wireguard-tools
  ];
}
