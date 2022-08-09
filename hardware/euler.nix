# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "vmd" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.blacklistedKernelModules = [ "nouveau" "bbswitch" "nvidia" "nvidia_modeset" "nvidia_drm" "nvidia-uvm" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.kernelParams = [ "acpi_rev_override" ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9e40f81c-c74d-479b-b57b-1a14d8ba0099";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."cryptroot".device = "/dev/disk/by-uuid/ec3b9a53-88a3-45af-9c53-f381a87f50fd";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/AC1C-DBEA";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/d38d6ac0-3fb8-49bb-8584-d15162d88c98"; }
    ];

  networking.useDHCP = false;
  networking.interfaces.wlp0s20f3.useDHCP = true;

  hardware.nvidia.powerManagement.enable = true;
  powerManagement.scsiLinkPolicy = "min_power";
  powerManagement.powertop.enable = true;
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  networking.hostName = "euler";
}