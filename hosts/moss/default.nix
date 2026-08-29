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

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages_6_12;

  networking.hostName = "moss";

  home-manager.users."mara" = {
    imports = [ ../../modules/home ];

    programs.claude.settings = {
      model = "sonnet";
      enableRelentlessMode = false;
    };

    desktop.windowManager = "gnome";

    home.homeDirectory = "/home/mara";
    home.username = "mara";
    home.stateVersion = "26.05";
    home.packages = [ inputs.deploy.packages.x86_64-linux.default ];
  };

  home-manager.extraSpecialArgs = {
    inherit inputs;
    username = "mara";
    realname = "Mara Schulke";
  };

  ocular.vpn = {
    # enable = true;
    peer = vpn.peers.moss;
    privateKeyFile = "/root/wireguard/keys/private";
  };

  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_17;
    enableTCPIP = true;
    authentication = pkgs.lib.mkOverride 10 ''
      local all all trust
      host  all all 127.0.0.1/32 trust
      host  all all ::1/128      trust
    '';
    initialScript = pkgs.writeText "init-postgres.sql" ''
      CREATE USER gamma WITH PASSWORD 'gamma' CREATEDB;
      CREATE DATABASE gamma OWNER gamma;
      CREATE ROLE mara WITH LOGIN SUPERUSER;
      CREATE DATABASE mara OWNER mara;
    '';
  };

  system.stateVersion = "26.05";
}
