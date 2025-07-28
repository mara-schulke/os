{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    (chromium.override { enableWideVine = true; })
    brave
    discord
    exercism
    firefox
    libreoffice
    libheif
    mgba
    slack
    steam
    spotify
    st
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "mara" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        brave
        firefox
        chromium
      '';
      mode = "0755";
    };
  };
}
