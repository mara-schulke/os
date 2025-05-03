{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware/maple.nix
    ./os
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ nvidia-vaapi-driver ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # services.xserver.displayManager.sessionCommands = ''
  #  xset s off -dpms
  # '';
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };

  boot = {
    plymouth = {
      enable = true;
      theme = "spinner";
      # logo = "/path/to/your/logo.png";
    };

    consoleLogLevel = 0;
    kernelParams = [
      "quiet"
      "splash"
      #"rd.systemd.show_status=false"
      #"rd.udev.log_level=3"
      #"vt.global_cursor_default=0"
    ];
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;

  hardware.enableAllFirmware = lib.mkForce true;
  hardware.firmware =
    with pkgs;
    lib.mkForce [
      linux-firmware
      firmwareLinuxNonfree
    ];

  time.timeZone = "Europe/Berlin";

  #console = {
  #font = "Lat2-Terminus16";
  #useXkbConfig = true;
  #};

  services.xserver.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb.layout = lib.mkForce "us";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  users.users.mara = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    home = "/home/mara";
  };
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    curl
    resources
    (chromium.override { enableWideVine = true; })
    liquidctl
  ];

  system.stateVersion = "25.05";
}
