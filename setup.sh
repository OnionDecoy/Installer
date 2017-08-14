#!/bin/bash
########################################################
# OnionDecoy post Installation Setup script            #
# Ubuntu server 16.04.0, x64                           #
#                                                      #
########################################################

# Let's create a function for colorful output
fuECHO () {
  local myRED=1
  local myWHT=7
  tput setaf $myRED -T xterm
  echo "$1" "$2"
  tput setaf $myWHT -T xterm
}


# Let's wait a few seconds to avoid interference with service messages
fuECHO "### Waiting a few seconds to avoid interference with service messages."
sleep 5

# Let's log for the beauty of it
set -e
exec 2> >(tee "install.err")
exec > >(tee "install.log")

fuECHO
fuECHO "### Please provide the number of Cowrie Onion Decoys (1-10)"
fuECHO
read -p "No_of_Cowrie_Onion_Decoys: " myCOWRIEs
myCOUNTER=0
while [  $myCOUNTER -lt $myCOWRIEs ]; do
    let myCOUNTER=myCOUNTER+1; 
    echo Creating Cowrie Onion Decoy $myCOUNTER
    docker run -tid --link cowrie --name onion_cowrie_$myCOUNTER oniondecoy/container-torrify
    sleep 6
    docker exec -ti onion_cowrie_$myCOUNTER onions
    echo ""
done

fuECHO
fuECHO "### Please provide the number of Glastopf Onion Decoys (1-10)"
fuECHO
read -p "No_of_Glastopf_Onion_Decoys: " myGLASTOPFs
myCOUNTER=0
while [  $myCOUNTER -lt $myGLASTOPFs ]; do
    let myCOUNTER=myCOUNTER+1; 
    echo Creating Glastopf Onion Decoy $myCOUNTER
    docker run -tid --link glastopf --name onion_glastopf_$myCOUNTER oniondecoy/container-torrify
    sleep 6
    docker exec -ti onion_glastopf_$myCOUNTER onions
    echo ""
done