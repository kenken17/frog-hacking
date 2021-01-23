#! /bin/bash

COMMAND_1='nmap -sV -sC $TARGET | highlight "^2[12]\/tcp|^80\/tcp"'
COMMAND_2='ffuf -c -recursion -t 64 -w "$W_COMMON" -u http://$TARGET/FUZZ'
COMMAND_3='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $TARGET ssh -s PORT'
COMMAND_4='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $TARGET http-post-form "/login.php:username=^USER^&password=^PASS^&login=Submit:F=Login failed"'
COMMAND_5='ssh $USER@$TARGET -p 22'
COMMAND_6='scp ~/Tools/linpeas.sh $USER@$TARGET:/tmp'
COMMAND_7='fcrackzip -D -v -p "$W_PASSWORD" file.zip'
COMMAND_8='binwalk -e file.jpg'
COMMAND_8='steghide extract -sf file.jpg'
COMMAND_a='7z x file.zip'

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
  echo ""
  echo "  x. Exit"
  echo ""
}

runV() {
  tmux setenv TARGET $TARGET

  tmux split-window -v
  sleep 0.1
  C="$@"
  tmux send-keys "$C"
}

runH() {
  tmux setenv TARGET $TARGET

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
    1-) runV $COMMAND_1;;
    1_) runH $COMMAND_1;;
    2) runV $COMMAND_2;;
    2-) runV $COMMAND_2;;
    2_) runH $COMMAND_2;;
    3) runV $COMMAND_3;;
    3-) runV $COMMAND_3;;
    3_) runH $COMMAND_3;;
    4) runV $COMMAND_4;;
    4-) runV $COMMAND_4;;
    4_) runH $COMMAND_4;;
    5) runV $COMMAND_5;;
    5-) runV $COMMAND_5;;
    5_) runH $COMMAND_5;;
    6) runV $COMMAND_6;;
    6-) runV $COMMAND_6;;
    6_) runH $COMMAND_6;;
    7) runV $COMMAND_7;;
    7-) runV $COMMAND_7;;
    7_) runH $COMMAND_7;;
    8) runV $COMMAND_8;;
    8-) runV $COMMAND_8;;
    8_) runH $COMMAND_8;;
    9) runV $COMMAND_9;;
    9-) runV $COMMAND_9;;
    9_) runH $COMMAND_9;;
    a) runV $COMMAND_a;;
    a-) runV $COMMAND_a;;
    a_) runH $COMMAND_a;;
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
