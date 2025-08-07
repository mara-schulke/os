{ ... }:

{
  nix.distributedBuilds = true;
  nix.settings.trusted-users = [
    "root"
    "mara"
  ];
  nix.settings.builders-use-substitutes = false;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.buildMachines = [
    {
      hostName = "builder";
      sshUser = "root";
      sshKey = "/home/mara/.ssh/builder";
      publicHostKey = "AAAAC3NzaC1lZDI1NTE5AAAAINPqSejXwLVx7S+W3dUmrB6OI71Sf951/KUnAEnHmyDt";
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

  home-manager.users.root = {
    home.homeDirectory = "/root";
    home.username = "root";
    home.stateVersion = "25.05";

    home.file.".ssh/config".text = ''
      Host *
        IdentityAgent /home/mara/.1password/agent.sock

      Host builder
        User root
        Hostname hemisphere.studio
        Port 22
        StrictHostKeyChecking no
        IdentityFile /home/mara/.ssh/builder
    '';
  };
}
