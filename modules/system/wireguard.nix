{
  inputs,
  ...
}:

let
  vpn = inputs.ocular.lib.vpn;
in
{
  imports = [ inputs.ocular.nixosModules.vpn ];

  services.hemisphere.vpn = {
    enable = true;
    peer = vpn.peers.maple;
    privateKeyFile = "/root/wireguard/keys/private";
  };
}
