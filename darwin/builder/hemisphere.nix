{
  lib,
  ...
}:

{
  nix.distributedBuilds = lib.mkForce true;
  nix.settings.builders-use-substitutes = lib.mkForce false;
  nix.settings.builders = [ "ssh://root@hemisphere-builder aarch64-linux" ];

  nix.buildMachines = [
    {
      hostName = "hemisphere-builder";
      sshUser = "root";
      sshKey = "/Users/mara.schulke/.ssh/id_ed25519";
      publicHostKey = "c3NoLWVkMjU1MTkgQUFBQUMzTnphQzFsWkRJMU5URTVBQUFBSU5QcVNlalh3TFZ4N1MrVzNkVW1yQjZPSTcxU2Y5NTEvS1VuQUVuSG15RHQgcm9vdEBtYXJhcy1zZXJ2ZXIK";

      systems = [ "aarch64-linux" ];
      supportedFeatures = [
        "kvm"
        "benchmark"
        "big-parallel"
      ];
      maxJobs = 2;
      protocol = "ssh";
    }
  ];

  environment.etc."ssh/ssh_config.d/200-hemisphere.conf".text = ''
    Host hemisphere-builder
      User root
      Hostname hemisphere.studio
      Port 22
      IdentityFile /Users/mara.schulke/.ssh/id_ed25519
  '';
}
