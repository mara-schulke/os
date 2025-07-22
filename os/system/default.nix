{ ... }:

{
  imports = [
    ./acpi.nix
    ./boot.nix
    ./fw.nix
    ./kernel.nix
    ./nix.nix
    ./pam.nix
    ./settings.nix
    ./virtualization.nix
  ];
}
