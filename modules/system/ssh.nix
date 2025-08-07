{ ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent /home/mara/.1password/agent.sock
    '';
  };
}
