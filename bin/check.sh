#!/bin/bash

########################################################
# Onion Decoy                                          #
# Check container and services script                  #
#                                                      #
########################################################
if [ -a /var/run/check.lock ];
  then
    echo "Lock exists. Exiting now."
    exit
fi

myIMAGES=$(cat /data/images.conf)

touch /var/run/check.lock

myUPTIME=$(awk '{print int($1/60)}' /proc/uptime)
for i in $myIMAGES
  do
    if [ "$i" != "ui-for-docker" ] && [ "$i" != "netdata" ];
      then
        myCIDSTATUS=$(docker exec $i supervisorctl status)
        if [ $? -ne 0 ];
          then
            myCIDSTATUS=1
          else
            myCIDSTATUS=$(echo $myCIDSTATUS | egrep -c "(STOPPED|FATAL)")
        fi
        if [ $myUPTIME -gt 4 ] && [ $myCIDSTATUS -gt 0 ];
          then
            echo "Restarting "$i"."
            systemctl stop $i
            sleep 5
            systemctl start $i
        fi
    fi
done

rm /var/run/check.lock
