#! /bin/bash

COMMAND_1='find / -perm -u=s -type f 2>/dev/null'

show_menus() {
  clear
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "                                Handyman                                      "
  echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo "  1) $COMMAND_1"
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
