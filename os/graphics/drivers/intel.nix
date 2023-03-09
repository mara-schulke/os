{ config, ... }:

{
  services.xserver.videoDrivers = [ "intel" ];
  system.nixos.tags = [ "internal" ];
}
