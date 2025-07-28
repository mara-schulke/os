{ ... }:

{
  nix.linux-builder = {
    enable = true;
    ephemeral = true;
    maxJobs = 4;
    config = {
      virtualisation.darwin-builder.diskSize = 40 * 1024;
      virtualisation.darwin-builder.memorySize = 8 * 1024;
      virtualisation.cores = 6;
      virtualisation.sharedDirectories.sharedHome = {
        source = "/Users/Shared";
        target = "/Users/Shared";
      };

      networking.firewall.enable = false;
    };
  };

  nix.settings.extra-trusted-users = [
    "@admin"
    "mara.schulke"
  ];

  launchd.daemons.linux-builder = {
    serviceConfig = {
      StandardOutPath = "/var/log/darwin-builder.log";
      StandardErrorPath = "/var/log/darwin-builder.log";
    };
  };
}
