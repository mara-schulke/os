{ config, pkgs, ... }:

{
  imports = [
    ./dns.nix
    #./gestures.nix
  ];

  services.fwupd.enable = true;
  services.openssh.enable = true;
  services.thermald.enable = true;
  services.fstrim.enable = true;
}
