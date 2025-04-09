{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware/maple.nix
    ./os
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [nvidia-vaapi-driver];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  # services.xserver.displayManager.sessionCommands = ''
  #  xset s off -dpms
  # '';
  services.xserver.videoDrivers = ["nvidia"];
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
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
  hardware.enableAllFirmware = lib.mkForce true;
  hardware.firmware = with pkgs; lib.mkForce [
    linux-firmware
    firmwareLinuxNonfree
  ];

  nixpkgs.config.allowUnfree = true;

  networking.wireless.enable = lib.mkForce false;
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

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

  programs.firefox.enable = true;
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
    neovim
    curl
    resources
    (chromium.override {
      enableWideVine = true;
    })
    liquidctl
  ];

  system.stateVersion = lib.mkForce "25.05";
}

