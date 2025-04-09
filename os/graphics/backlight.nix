{ pkgs, ... }:

{
  programs.light.enable = true;
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils.out}/bin/chgrp video $sys$devpath/brightness", RUN+="${pkgs.coreutils.out}/bin/chmod g+w $sys$devpath/brightness"
  '';
}
