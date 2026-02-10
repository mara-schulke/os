{
  config,
  pkgs,
  lib,
  ...
}:

{
  users.users.mara.extraGroups = [
    "kvm"
    "libvirtd"
  ];

  services.udev.packages = lib.singleton (
    pkgs.writeTextFile {
      name = "kvmfr";
      text = ''
        SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660", TAG+="uaccess"
      '';
      destination = "/etc/udev/rules.d/70-kvmfr.rules";
    }
  );

  boot.extraModulePackages = [ config.boot.kernelPackages.kvmfr ];
  boot.initrd.kernelModules = [
    "kvmfr"
    "vfio_pci"
    "vfio"
    "vfio_iommu_type1"
  ];

  boot.kernelParams = [ "kvmfr.static_size_mb=128" ];

  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    dnsmasq
    spice
    spice-gtk
    spice-protocol
    virt-manager
    virt-viewer
    looking-glass-client
    virtio-win
    win-spice
  ];

  services.spice-vdagentd.enable = true;

  networking.firewall.trustedInterfaces = [ "virbr0" ];

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        verbatimConfig = ''
          namespaces = []
          cgroup_device_acl = [
            "/dev/null", "/dev/full", "/dev/zero",
            "/dev/random", "/dev/urandom",
            "/dev/ptmx", "/dev/kvm", "/dev/kqemu",
            "/dev/rtc","/dev/hpet", "/dev/vfio/vfio",
            "/dev/kvmfr0"
          ]
        '';
      };
    };
    spiceUSBRedirection.enable = true;
  };
}
