{ config, ... }:

{
  services.xserver.videoDrivers = [ "amd" ];
  system.nixos.tags = [ "internal" ];
}
