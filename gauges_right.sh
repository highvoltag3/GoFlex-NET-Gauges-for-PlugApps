#!/bin/sh

###############################################
#											  #
#   Made by: Dario Novoa V.                	  #
#   darionovoa [ at ] ideartte.com			  #	
#   Activate the front "Gauges" LED lights    #
#   to show the amount of used space in the   #
#   specified device						  #
#											  #
#	usage add * * * * * /path/to/this/script  #
#	to the end of your cronjobs 			  #
#	using: $  crontab -e 					  #
#											  #
#	This will execute the script every 1min   #
#											  #
###############################################

DISC=$1
PERCENT=`df -h|grep $DISC|awk '{print $5}'`

# Let's remove the % from the Percent variable like this var=${var%\%}
PERCENT=${PERCENT%\%}

#When we hit 95% 972.8Mb or more flash the last 2 leds in a synchronized way to warn me I'm running out of space
if [ $PERCENT -ge 95 ]
then

# 3 is the upper most led and 0 is the one on the bottom
  echo default-on > /sys/class/leds/status\:white\:right0/trigger
  echo default-on > /sys/class/leds/status\:white\:right1/trigger
  echo timer > /sys/class/leds/status\:white\:right2/trigger
  echo 1000 > /sys/class/leds/status\:white\:right2/delay_on
  echo timer > /sys/class/leds/status\:white\:right3/trigger
  echo 500 > /sys/class/leds/status\:white\:right3/delay_on
  
  echo "Your using an amount of disk space that is Greater or equal to 85%"
 
elif [ $PERCENT -le 75 ]
then
  echo default-on > /sys/class/leds/status\:white\:right0/trigger
  echo default-on > /sys/class/leds/status\:white\:right1/trigger
  echo default-on > /sys/class/leds/status\:white\:right2/trigger
  
  echo none > /sys/class/leds/status\:white\:right3/trigger

  echo "Your using an amount of disk space that is less or equal to 75%"


elif [ $PERCENT -le 50 ]
then
  echo default-on > /sys/class/leds/status\:white\:right0/trigger
  echo default-on > /sys/class/leds/status\:white\:right1/trigger
  
  echo none > /sys/class/leds/status\:white\:right2/trigger
  echo none > /sys/class/leds/status\:white\:right3/trigger

  echo "Your using an amount of disk space that is less or equal to 50%"


elif [ $PERCENT -le 25 ]
then 
  echo default-on > /sys/class/leds/status\:white\:right0/trigger
  
  echo none > /sys/class/leds/status\:white\:right1/trigger
  echo none > /sys/class/leds/status\:white\:right2/trigger
  echo none > /sys/class/leds/status\:white\:right3/trigger

  echo "Your using an amount of disk space that is less or equal to 25%"


else
  echo none > /sys/class/leds/status\:white\:right0/trigger
  echo none > /sys/class/leds/status\:white\:right1/trigger
  echo none > /sys/class/leds/status\:white\:right2/trigger
  echo none > /sys/class/leds/status\:white\:right3/trigger
fi