#!/bin/sh
# bcast — type a message into every agent window (claude/codex/agy/grok) of tmux session a: sh ~/aext/bcast.sh cont
tmux list-windows -t a -F '#{window_index} #{window_name}' | awk '$2~/^(claude|codex|agy|grok)/{print $1}' | while read -r w; do tmux send-keys -t "a:$w.0" -l "$*"; tmux send-keys -t "a:$w.0" Enter; done
