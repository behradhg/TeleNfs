#!/bin/bash
# =====================================================================================================
# Copyright (C) steady.sh v1.2 2016 iicc (@iicc1)
# Max steady.sh 
# =====================================================================================================
# tnx to DBteam

# Some script variables
OK=0
BAD=0
NONVOLUNTARY=1
NONVOLUNTARYCHECK=0
VOLUNTARY=1
VOLUNTARYCHECK=0
I=1
BOT=bet  # You can put here other bots. Also you can change it to run more than one bot in the same server.
API=api  # You can put here other bots. Also you can change it to run more than one bot in the same server.
RELOADTIME=50  # Time between checking cpu calls of the cli process. Set the value high if your bot does not receive lots of messages.


function tmux_mode {

sleep 0.5
clear
# Space invaders thanks to github.com/windelicato
f=3 b=4
for j in f b; do
  for i in {0..7}; do
    printf -v $j$i %b "\e[${!j}${i}m"
  done
done
bld=$'\e[1m'
rst=$'\e[0m'

echo -e "\e[100m                                 Steady -- script                                 \e[00;37;40m"
echo -e "\e[100m                                 Writed by behrad                                 \e[00;37;40m"
echo -e "\e[01;34m                                  For Max source                                  \e[00;37;40m"
echo ""

sleep 1

# Checking if the bot folder is in HOME
echo -e "$bld$f4 CHECKING INSTALLED nfs-BOT...$rst"
sleep 1
echo -e "$f2 $BOT FOUND IN YOUR HOME DIRECTORY$rst"
sleep 1

sleep 1
echo -e "$bld$f4 CHECKING PROCESSES...$rst"
sleep 1

# Looks for the number of screen/telegram-cli processes
CLINUM=`ps -e | grep -c tg`
echo "$f2 RUNNING $CLINUM TELEGRAM-CLI PROCESS$rst"
sleep 1

# =====Setup ends===== #

# Opening new tmux in a daemon
echo -e "$bld$f4 ATTACHING TMUX AS DAEMON...$rst"
# It is recommended to clear cli status always before starting the bot
rm ../.telegram-cli/data 2>/dev/null
# Nested TMUX sessions trick 
TMUX= tmux new-session -d -s $BOT "./tg -s ./bot/bot.lua"
api= tmux new-session -d -s $API "lua api/bot.lua"
sleep 1
echo -e "$f2 API bot started$rst"
echo -e "$f2 Telegram-cli enabled$rst"

while true; do
	
	if [ $? != 0 ]; then
		I=$(( $I + 1 ))
		if [ $I -ge 3 ]; then
			kill $CLIPID
			tmux kill-session -t $BOT
			tmux kill-session -t $API
			rm ../.telegram-cli/data 2>/dev/null
			NONVOLUNTARY=0
			NONVOLUNTARYCHECK=0
			VOLUNTARY=0
			VOLUNTARYCHECK=0
		fi
	else 
		I=1
	fi
	
	if [ $NONVOLUNTARY != 0 ] || [ $VOLUNTARY != 0 ]; then
		echo -e "$f5 BOT RUNNING!$rst"
		OK=$(( $OK + 1 ))

	else
		echo -e "$f5 BOT NOT RUNING, TRYING TO RELOAD IT...$rst"
		BAD=$(( $BAD + 1 ))
		sleep 1
		
		rm ../.telegram-cli/data 2>/dev/null 

		tmux kill-session -t $BOT
	
		TMUX= tmux new-session -d -s $BOT "./tg -s bot/bot.lua"
		api= tmux new-session -d -s $API "lua api/bot.lua"
		sleep 1
		

	fi
	
	# Clear cache after 10h
	if [ "$OK" == 2400 ]; then
		sync
		sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'
	fi

	sleep $RELOADTIME
	
done

}





if [ $# -eq 0 ]
then
	echo -e "\e[1m"
	echo -e ""
	echo "TMUX multiplexer option has been triggered." >&2
	echo "Starting script..."
	echo "Max is best"
	sleep 1.5
	echo -e "\e[0m"
	tmux_mode
	exit 1

fi


done