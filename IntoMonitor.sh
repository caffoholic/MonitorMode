#!/usr/bin/env bash

R="\033[91m"
G="\033[92m"
P="\033[95m"
W="\033[0m"

COLS=$( tput lines )
MIDDLE=$(($COLS / 2))

clear

function help_information(){
  tput cup $MIDDLE
  echo -e "${R}[?]${W}\tUsage:\t$1 ${G}[up/down] ${P}[Wireless-Interface]${W}"
  tput cup $( tput lines ) 0
  exit
}

#SET-OPTION
if [ -z $1 ]
then
  #IF SET-OPTION IS EMPTY
  tput cup $MIDDLE
  echo -e "${R}[!]${W}\tSwitch monitor mode up / down?"
  tput cup $( tput lines ) 0
  exit
elif [ $1 == '-h' ]
then
  help_information
else
  #IF LEGIT OPTION
  SET=$1
fi

#INTERFACE-OPTION
if [ -z $2 ]
then
  #IF INTERFACE IS EMPTY
  tput cup $MIDDLE
  echo -e "${R}[!]${W}\tYou need to specify an interface${W}"
  tput cup $( tput lines ) 0
  exit
else
  #IF LEGIT INTERFACE
  INTER=$2
fi

#EXECUTE SCRIPT

if [ $SET == 'up' ]
then
  OPT="monitor"
else
  OPT="managed"
fi

  tput cup $MIDDLE

  #DOWN
  sudo ip link set $INTER down
  echo -e "${G}[~]\t${INTER} is down.."
  sleep 1

  #MANAGED
  sudo iw dev $INTER set type $OPT
  echo -e "[~]\t${INTER} is set to ${OPT}"
  sleep 1

  #UP
  sudo ip link set $INTER up
  echo -e "[~]\t${INTER} is up!"
  sleep 1

  #CONFIRM
  echo -e "[!]\t${P}Everything went fine. Done!${W}"

tput cup $( tput lines ) 0
exit
