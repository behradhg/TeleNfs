token=" " 
 function start_bot() {
 ./tg -p $2 -s /bot/bot.lua
 
 }
 
 function create_bot() {
  ./tg -p $2 -s bot.lua
 }
 
function rf() {
rm -rf config.lua
lua cr.lua
 }
 
 function logo_play() {
    declare -A txtlogo
    seconds="0.10"
    txtlogo[1]="NFS bot has bin RUNING"
    txtlogo[5]="runing bot $2"
    txtlogo[2]="1"
    txtlogo[3]="2"
    txtlogo[4]="3"
    printf "\033[38;5;600m\t"
    for i in ${!txtlogo[@]}; do
        for x in `seq 0 ${#txtlogo[$i]}`; do
            printf "${txtlogo[$i]:$x:1}"
            sleep $seconds
        done
        printf "\n\t"
    done
    printf "\n"
}

function help_play() {
    declare -A txtlogo
    seconds="0.1"
 txtlogo[1]="Help for $0 sh script :"
 txtlogo[2]="$0 -help for see help"
 txtlogo[3]="$0 -list for see list of bots"
 txtlogo[4]="$0 -cr <botname> for create a bot"
 txtlogo[5]="$0 -r <botname> for run bot with hash"
 txtlogo[6]="$0 -killall for delete all bots"
 txtlogo[7]="$0 -tg for install tg 1222"
    printf "\033[38;5;600m\t"
    for i in ${!txtlogo[@]}; do
        for x in `seq 0 ${#txtlogo[$i]}`; do
            printf "${txtlogo[$i]:$x:1}"
            sleep $seconds
        done
        printf "\n\t"
    done
    printf "\n"
}
function tg() {
  wget https://valtman.name/files/telegram-cli-1222
  mv telegram-cli-1222 tg
  chmod 7777 tg
  
}

if [[ $1 == "-r" ]]; then
if [ ! -f "./tg" ]; then echo "Please install tg"; exit; fi
COUNTER=1
logo_play
   while(true) do
   screen ./tg -s ./bot/bot.lua
   curl "https://api.telegram.org/bot$token/sendmessage" -F "chat_id=-1001110522415" -F "text=#NFS-crashing
   runing ${COUNTER} times"
 let COUNTER=COUNTER+1 
 done 
  curl "https://api.telegram.org/bot$token/sendmessage" -F "chat_id=-1001110522415" -F "text=#NFS-crashing
  #bot dwon :("
   exit
   elif [[ $1 == "-api" ]]; then
   while(true) do
   lua api/bot.lua
   done
   exit
   elif [[ $1 == "-run" ]]; then
   chmod 777 steady.sh
   screen ./steady.sh
   elif [[ $1 == "-cr" ]]; then
if [ ! -f "./tg" ]; then echo "Please install tg"; exit; fi
   echo "creating bot $2"
   create_bot $2
   exit
 elif [[ $1 == "-list" ]]; then
 ls ../.telegram-cli
 elif [[ $1 == "-rf" ]]; then
 rf
  elif [[ $1 == "-apt" ]]; then
 echo -e "\e[1;36mUpdating packages\e[0m"
    sudo apt-get update -y

    echo -e "\e[1;36mInstalling dependencies\e[0m"
    sudo apt-get install libreadline-dev libssl-dev lua5.2 luarocks liblua5.2-dev git make unzip redis-server curl libcurl4-gnutls-dev -y
    
    echo -e "\e[1;36mInstalling LuaRocks from sources\e[0m"
    
    git clone http://github.com/keplerproject/luarocks
    cd luarocks
    ./configure --lua-version=5.2
    make build
    sudo make install
    cd ..
    
    echo -e "\e[1;36mInstalling rocks\e[0m"
    
    rocks="luasocket luasec redis-lua lua-term serpent dkjson Lua-cURL multipart-post"
    for rock in $rocks; do
        sudo luarocks install $rock
    done
 elif [[ $1 == "-tg" ]]; then
 tg
 elif [[ $1 == "-killall" ]]; then
 rm -rf ../.telegram-cli
 elif [[ $1 == "-help" ]]; then
help_play

 exit
fi
exit
