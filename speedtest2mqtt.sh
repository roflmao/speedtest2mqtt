#!/bin/bash
#sends speedtest-cli data as json to MQTT broker
/usr/local/bin/speedtest-cli --simple | /usr/local/bin/perl -pe 's/^(.*): (.*) (.*?)(\/s)?\n/"$1_$3": $2, /m' | cut -d',' -f 1-3 | while read line
do
# Raw message to MQTT
  echo "{$line}"  | /usr/local/bin/mosquitto_pub -h 192.168.67.11 -i k77 -l -t "speedtest/k77"
done

