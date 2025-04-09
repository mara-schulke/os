{ config, pkgs, ... }:

{
  # systemd.timers.dns = {
  #  after = ["network.target"];
  #  wantedBy = ["timers.target"];
  #  partOf = [ "dns.service" ];
  #  timerConfig.OnCalendar = "minutely";
  # };

  systemd.services.dns = {
    description = "Automatically set the A-Record of my domain to the public IP of this machine";
    serviceConfig.Type = "oneshot";
    path = [ pkgs.nix ];
    script = ''
      #!/usr/bin/env sh

      authorization="Authorization: sso-key $(cat /etc/nixos/secrets/dns/authorization)"

      domain='schulke.xyz'
      a="${config.networking.hostName}.hardware"
      api="https://api.godaddy.com/v1/domains/$domain/records/A/$a"

      ip=`/run/current-system/sw/bin/dig @resolver4.opendns.com myip.opendns.com +short -4`

      echo "${config.networking.hostName}:"
      echo "  ip: $ip"
      echo

      records=`/run/current-system/sw/bin/curl -s -X GET -H "$authorization" $api`

      echo "records for $a.$domain:"
      echo "  $records"
      echo

      if [[ $records == *$ip* ]]; then
        echo "$a.$domain is already up to date"
        exit 0
      fi

      /run/current-system/sw/bin/curl -s -X PUT -H "$authorization" $api \
          -H 'Content-Type: application/json' \
          -d "[ { \"data\": \"$ip\", \"ttl\": 600 } ]" \
          --fail

      if [ 0 -eq $? ]; then
        echo "set $a.$domain to $ip"
        exit 0
      else
        echo "failed to set $a.$domain"
        exit 1
      fi
    '';
  };
}
