#!/bin/bash
#
printf "\033c"
echo "=================================================="
echo "--------------------------------------------------"
host=$(hostname)
full=$(finger $(whoami) | egrep -o 'Name: [-a-zA-Z0-9 ]{1,}' | cut -d ':' -f 2 )
ip=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | cut -d \  -f2)
ipa="$(ifconfig | grep -A 1 'eth0' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 1)"
ram=$(sysctl -n hw.memsize)
ramsize=$(expr $ram / $((1024**3)))
core=$(sysctl hw.ncpu | egrep -o ':[-a-zA-Z0-9 ]{1,}' | cut -d ':' -f 2 )
diska=$(df -h | grep 'Gi' | cut -d \  -f3,4)
diskb=$(df -h | grep 'Gi' | cut -d \  -f2,3,5,6,7 )
diskc=$(df -h | grep 'Gi' | cut -d \  -f2,3,3,3,3,8,9 )
cpuusage=$(top -l 1 | grep -E '^CPU' | cut -d \  -f3 )
memusage=$(top -l 1 | grep -E '^Phys')
diskusage=$(top -l 1 | grep -E '^Disk')
echo $ipa
echo "Host name is                  : "$host
echo "Ip address of the machine is  : "$ip
echo "Your Full name is             :"$full
echo "Your total Ram is             : "${ramsize}"GigaByte"
echo "Cpu Core Counts               :"$core "cores"
echo "Disk Capacity                 :"$diska"gaByte"
echo "Disk Usage                    :"$diskb"gaByte"
echo "Disk availabe                 :"$diskc"gaByte"
echo "--------------------------------------------------"
echo "You Cpu using : "$cpuusage "on this user"
echo "--------------------------------------------------"
echo $memusage
echo "--------------------------------------------------"
echo $diskusage
echo "--------------------------------------------------"
echo "==================================================="
