#!/bin/bash

online=0
offline=0
skipped=0
checked=0

echo "=== Retail IT DEVICE HEALTH CHECK ===="
echo
printf "%-12s %-18s %10s\n" "HOSTNAME" "IP ADDRESS" "STATUS"
echo "------------------------------------------"

while IFS=, read -r asset type host location ip status
do

     checked=$((checked + 1))

     if [ "$ip" = "DHCP" ]; then
        result="SKIPPED"
        skipped=$((skipped + 1))

     elif ping -c 1 -W 1 "$ip" > /dev/null 2>&1; then
        result="ONLINE"
        online=$((online + 1))

     else
        result="OFFLINE"
        offline=$((offline + 1))
     fi

     printf "%-12s %-18s %-10s\n" "$host" "$ip" "$result"
done < <(tail -n +2 devices.csv)


echo "-------------------------------------"
echo
echo "Devices Checked: $checked"
echo "Online:          $online"
echo "Offline:         $offline"
echo "Skipped:         $skipped"


