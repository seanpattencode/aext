#!/bin/sh
# a awake [off] — Mac keeps running with the lid closed: Amphetamine's whole feature is one hidden pmset flag.
# aext extension 2026-10-04 (wastebook draft 10-03, lid-trial proven on macOS 27.2: kernel "System sleep prevented by
# kPMUserDisabledAllSleep", 28 min shut, ssh served). Flag is system-wide (-a/-b/-c ignored) so assume battery too:
# don't bag it armed. Persists across reboots until off.
[ "$(uname)" = Darwin ] || { echo "x mac only — or: a ssh <mac> 'sudo pmset disablesleep 1'"; exit 1; }
v=1; [ "$1" = off ] && v=0
sudo pmset disablesleep $v || exit 1
pmset -g | grep -i sleepdisabled
[ $v = 1 ] && echo "✓ awake with lid closed, even on battery (don't bag it) — undo: sh $0 off" || echo "✓ normal sleep restored"
