{ config, ... }:

{
  services.acpid = {
    enable = true;
    lidEventCommands = ''
      export PATH=/run/wrappers/bin:/run/current-system/sw/bin:$PATH
      export XAUTHORITY=/run/user/1000/gdm/Xauthority
      export DISPLAY=:0

      export LID_STATE=`awk '{print$NF}' /proc/acpi/button/lid/LID0/state`
      export AC_STATE=`cat /sys/class/power_supply/AC/online`

      if [[ $LID_STATE == "closed" && $AC_STATE == "0" ]]; then
        sudo -u mara slock
      fi
    '';
  };
}
