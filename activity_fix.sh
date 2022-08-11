#!/bin/bash

miner_name=$(docker exec miner miner print_keys|awk '/pubkey/ {split($1,a,"\""); print a[2]}')
height=$(curl -s https://api.helium.io/v1/blocks/height | grep -Po '"height":[^}]+' | sed -e 's/^"height"://')
last_poc_challenge=$(curl -s https://api.helium.io/v1/hotspots/$miner_name |grep -Po '"last_poc_challenge":[^\,]+' | sed -e 's/^"last_poc_challenge"://')
gap=$(($height - $last_poc_challenge))
echo
if [ "$gap" -gt 200 ];
then
    echo "No activity for at least 200 blocks\nRestarting miner service...";
    docker restart miner
else
    echo "Miner activity: Normal";
fi;
echo
