{ pkgs, ... }:

{
  home.packages = with pkgs; [
    setzer
    sqlitebrowser
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "mara" ];
  };
}
