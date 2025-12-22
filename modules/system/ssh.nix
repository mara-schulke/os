{ ... }:

{
  programs.ssh = {
    enable = true;
    extraConfig = ''
      Host *
          IdentityAgent /home/mara/.1password/agent.sock
    '';
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
}
