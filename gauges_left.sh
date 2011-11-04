#!/bin/sh

###############################################
#                                             #
#   Made by: Dario Novoa V.                   #
#   darionovoa [ at ] ideartte.com            #
#   Activate the front "Gauges" LED lights    #
#   to show the amount of used space in the   #
#   specified device                          #
#                                             #
# usage add * * * * * /path/to/this/script    #
# to the end of your cronjobs                 #
# using: $  crontab -e                        #
#                                             #
# This will execute the script every 1min     #
# Read the README for a detailed step by step #
#                                             #
###############################################

DISC=$1
PERCENT=`df -h|grep $DISC|awk '{print $5}'`

# Let's remove the % from the Percent variable like this var=${var%\%}
PERCENT=${PERCENT%\%}

if [ $PERCENT -le 25 ]
then 
  echo default-on > /sys/class/leds/status\:white\:left0/trigger
  
  echo none > /sys/class/leds/status\:white\:left1/trigger
  echo none > /sys/class/leds/status\:white\:left2/trigger
  echo none > /sys/class/leds/status\:white\:left3/trigger

  echo "Your using an amount of disk space that is less or equal to 25%"

elif [ $PERCENT -gt 25 -o $PERCENT -le 50 ]
then
  echo default-on > /sys/class/leds/status\:white\:left0/trigger
  echo default-on > /sys/class/leds/status\:white\:left1/trigger
  
  echo none > /sys/class/leds/status\:white\:left2/trigger
  echo none > /sys/class/leds/status\:white\:left3/trigger

  echo "Your using an amount of disk space that is less or equal to 50%"

elif [ $PERCENT -gt 50 -o $PERCENT -le 75 ]
then
  echo default-on > /sys/class/leds/status\:white\:left0/trigger
  echo default-on > /sys/class/leds/status\:white\:left1/trigger
  echo default-on > /sys/class/leds/status\:white\:left2/trigger
  
  echo none > /sys/class/leds/status\:white\:left3/trigger

  echo "Your using an amount of disk space that is less or equal to 75%"

elif [ $PERCENT -gt 75 -o $PERCENT -le 95 ]
then

  echo default-on > /sys/class/leds/status\:white\:left0/trigger
  echo default-on > /sys/class/leds/status\:white\:left1/trigger
  echo default-on > /sys/class/leds/status\:white\:left2/trigger
  
  echo none > /sys/class/leds/status\:white\:left3/trigger

  echo "Your using an amount of disk space that is greater than 75 but less than 95%"

#When we hit 95% 972.8Mb or more flash the last 2 leds in a synchronized way to warn me Im running out of space
elif [ $PERCENT -gt 95 -o $PERCENT -le 100 ]
then

#3 is the upper most led and 0 is the one on the bottom
  echo default-on > /sys/class/leds/status\:white\:left0/trigger
  echo default-on > /sys/class/leds/status\:white\:left1/trigger
  echo timer > /sys/class/leds/status\:white\:left2/trigger
  echo 1000 > /sys/class/leds/status\:white\:left2/delay_on
  echo timer > /sys/class/leds/status\:white\:left3/trigger
  echo 500 > /sys/class/leds/status\:white\:left3/delay_on
  
  echo "Your using an amount of disk space that is Greater or equal to 95%"

else

#We got no idea so let's turn all off
  echo none > /sys/class/leds/status\:white\:left0/trigger
  echo none > /sys/class/leds/status\:white\:left1/trigger
  echo none > /sys/class/leds/status\:white\:left2/trigger
  echo none > /sys/class/leds/status\:white\:left3/trigger

fi