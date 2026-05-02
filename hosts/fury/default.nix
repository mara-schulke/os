{
  inputs,
  lib,
  pkgs,
  ...
}:

let
  vpn = inputs.ocular.lib.vpn;
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.ocular.nixosModules.vpn

    ../../modules/system
    ./hardware-configuration.nix
  ];

  networking.hostName = "fury";

  home-manager.users."mara" = {
    imports = [ ../../modules/home ];

    desktop.windowManager = "none";

    home.homeDirectory = "/home/mara";
    home.username = "mara";
    home.stateVersion = "26.05";
    home.packages = [ inputs.deploy.packages.x86_64-linux.default ];
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
    username = "mara";
    realname = "Mara";
  };

  ocular.vpn = {
    enable = true;
    peer = vpn.peers.fury;
    privateKeyFile = "/root/wireguard/keys/private";
  };

  sphere.graphics.gpu.nvidia.enable = true;
  hardware.nvidia.package = lib.mkForce config.boot.kernelPackages.nvidiaPackages.beta;

  # ---------------------------------------------------------------------------
  # Override common desktop.nix (which unconditionally enables GNOME/GDM)
  # ---------------------------------------------------------------------------

  services.xserver.enable = lib.mkForce false;
  services.displayManager.gdm.enable = lib.mkForce false;
  services.desktopManager.gnome.enable = lib.mkForce false;

  # ---------------------------------------------------------------------------
  # Gamescope + Steam Deck UI session via greetd (auto-login, no display manager)
  # ---------------------------------------------------------------------------

  programs.steam.gamescopeSession.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.gamescope} -W 3840 -H 2160 -w 3840 -h 2160 --adaptive-sync -f --steam -- steam -steamdeck -steamos3 -gamepadui";
        user = "mara";
      };
    };
  };

  # Suppress greetd/gamescope boot chatter from VT; errors still go to journal
  systemd.services.greetd.serviceConfig.StandardOutput = "null";

  services.libinput.enable = true;

  # ---------------------------------------------------------------------------
  # Silent boot
  # ---------------------------------------------------------------------------

  boot.kernelParams = [
    "quiet"
    "splash"
    "rd.udev.log_level=3"
    "udev.log_level=3"
    "vt.global_cursor_default=0"
    "loglevel=3"
  ];

  boot.initrd.verbose = false;
  boot.consoleLogLevel = 0;

  # ---------------------------------------------------------------------------
  # Controller / gamepad support
  # ---------------------------------------------------------------------------

  users.users.mara.extraGroups = [
    "wheel"
    "audio"
    "docker"
    "i2c"
    "input"
    "libvirtd"
    "lp"
    "networkmanager"
    "video"
    "gamepad"
  ];

  hardware.steam-hardware.enable = true;

  system.stateVersion = "26.05";
}
