{ ... }:

{
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "mara" ];
    };
  };

  users.users.mara.openssh.authorizedKeys.keys = [
    ''ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINQzqzXz57EF6Z9anpzFhK4a1LscLC+e4W4IWiuJ0d5G mara''
  ];
}
