#!/bin/bash

########################################################
# Onion Decoy                                          #
# Container Data Cleaner                               #
#                                                      #
########################################################

# Set persistence
myPERSISTENCE=$2

# Check persistence
if [ "$myPERSISTENCE" = "on" ];
  then
    echo "### Persistence enabled, nothing to do."
    exit
fi

# Let's create a function to clean up and prepare cowrie data
fuCOWRIE () {
  rm -rf /data/cowrie/*
  mkdir -p /data/cowrie/log/tty/ /data/cowrie/downloads/ /data/cowrie/keys/ /data/cowrie/misc/
  chmod 760 /data/cowrie -R
  chown tpot:tpot /data/cowrie -R
}

# Let's create a function to clean up and prepare elk data
fuELK () {
  # ELK data will be kept for <= 90 days, check /etc/crontab for curator modification
  # ELK daemon log files will be removed
  rm -rf /data/elk/log/*
  mkdir -p /data/elk/logstash/conf 
  chmod 760 /data/elk -R
  chown tpot:tpot /data/elk -R
}

# Let's create a function to clean up and prepare glastopf data
fuGLASTOPF () {
  rm -rf /data/glastopf/*
  mkdir -p /data/glastopf
  chmod 760 /data/glastopf -R
  chown tpot:tpot /data/glastopf -R
}

# Let's create a function to clean up and prepare suricata data
fuSURICATA () {
  rm -rf /data/suricata/*
  mkdir -p /data/suricata/log
  chmod 760 -R /data/suricata
  chown tpot:tpot -R /data/suricata
}

case $1 in
  cowrie)
    fuCOWRIE $1
  ;;
  elk)
    fuELK $1
  ;;
  glastopf)
    fuGLASTOPF $1
  ;;
  suricata)
    fuSURICATA $1
  ;;
esac
