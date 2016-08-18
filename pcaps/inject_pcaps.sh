#!/bin/bash
# JS
# Randomizations added by SMace - Feb 2016
#Just in case....
modprobe dummy
ifconfig dummy0 up
ifconfig dummy0 promisc

SCRIPTPATH=$( cd $(dirname $0) ; pwd -P )
cd $SCRIPTPATH
## PCAP Array
pcaplist=`ls /root/Alienvault-Demo/pcaps/*.pcap`
 # Read into array variable.
pcap=($pcaplist)
# Count how many elements.
num_pcap=${#pcap[*]}

while true
do
        ## for pcap in `ls *.pcap`
                tcpreplay-edit -N '10.0.0.0/8:192.168.100.76/30,192.168.0.0/16:192.168.100.74/28' -i dummy0 --pps=5 ${pcap[$((RANDOM%num_pcap))]}
##Adjust as needed to randomize sleepytime
number=0   #initialize
RANGE=5400 #in seconds
FLOOR=20   # in seconds
while [ "$number" -le $FLOOR ]
do
  number=$RANDOM
  let "number %= $RANGE"  # Scales $number down within $RANGE.
done
sleep $number
done