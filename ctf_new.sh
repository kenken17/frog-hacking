#!/bin/bash

if tmux info &> /dev/null; then 
  echo 'Nested tmux session not allowed!'
else
  if [ -z $1 ]; then
    echo "CTF Name?"
  else
    mkdir -p ~/ctf/$1
    cd ~/ctf/$1

    touch nmap
    touch notes.md

    SESSION=$1
    SESSION_EXISTS=$(tmux list-sessions | grep $SESSION)

    if [ "$SESSION_EXISTS" = "" ]; then
      # Main window
      tmux new-session -d -s "$SESSION"
      tmux rename-window -t 1 'ovpn' # current tmux index start with 1

    # Note taking window
    tmux new-window -t "$SESSION":2 -n 'notes'
    tmux send-keys -t 'notes' 'vim notes.md' Enter
    tmux send-keys -t 'notes' ':q' Enter # to quit the nerdtree

    # nmap window
    tmux new-window -t "$SESSION":3 -n 'nmap'

    if [ -z $2 ]; then
      tmux send-keys -t 'nmap' "map_version -oN nmap "
    else
      tmux send-keys -t 'nmap' "map_version -oN nmap $2" Enter
    fi

    tmux split-window -t 'nmap' -h
    tmux select-pane -t 'nmap' -R

    if [ -z $2 ]; then
      tmux send-keys -t 'nmap.right' "go_http "
    else
      tmux send-keys -t 'nmap.right' "go_http $2" Enter
    fi

    # Hacking window
    tmux new-window -t "$SESSION":4 -n 'nc'
    tmux send-keys -t 'nc' 'nc -lvp 4444'
    fi

  # Start hacking!
  tmux attach-session -t "$SESSION":3
  fi
fi
