{ pkgs, lib, ... }:

{
  hardware.enableAllFirmware = lib.mkForce true;
  hardware.firmware =
    with pkgs;
    lib.mkForce [
      linux-firmware
      firmwareLinuxNonfree
    ];
}
