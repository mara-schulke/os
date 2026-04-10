{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    alacritty
    # (chromium.override { enableWideVine = true; })
    brave
    blender
    # davinci-resolve
    discord
    firefox
    libheif
    mgba
    lunar-client
    slack
    spotify
    steam
    thunderbird
    vivaldi
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    # Force Steam to use NVIDIA GPU
    gamescopeSession.env = {
      DRI_PRIME = "0";
      __NV_PRIME_RENDER_OFFLOAD = "1";
      __VK_LAYER_NV_optimus = "NVIDIA_only";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
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
