{ config, pkgs, ... }:

let
  devices = [ "riemann" "fermat" ];
in {
   networking.firewall.allowedTCPPorts = [ 8384 22000 ];
   networking.firewall.allowedUDPPorts = [ 21027 22000 ];

   services = {
     syncthing = {
       enable = true;
       user = "mara";
       dataDir = "/home/mara/Documents";
       #configDir = "/home/myusername/Documents/.config/syncthing";

       overrideDevices = true;
       overrideFolders = true;

       devices = {
         "riemann" = { id = "riemann"; };
         "fermat" = { id = "fermat"; };
       };

       devices = {
         "riemann" = {
           id = "6HN4PZT-JHVRV63-DFQFST5-INHU5P2-ZCE4MA2-U5VZJEA-WOROBA4-Z2RLJQH";
           name = "riemann";
         };
         "fermat" = {
           id = "VWVM3FN-BAH5ZB6-GKLMTLK-EFJP2IF-HO3WPIB-CIQIGFP-726SK75-LUKQTAO";
           name = "fermat";
         };
       };

       folders = {
         "Documents" = {
           path = "/home/mara/Documents";
           devices = ${devices};
         };
         "Workspace" = {
           path = "/home/mara/Workspace";
           devices = ${devices};
         };
       };
     };
  };
}
