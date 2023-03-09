{ config, ... }:

{
  imports = [
    ./acpi.nix
    ./boot.nix
    ./kernel.nix
    ./nix.nix
    ./pam.nix
    ./settings.nix
    ./virtualization.nix
  ];
}
