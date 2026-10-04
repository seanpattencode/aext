#!/bin/sh
# a pedal — install keyd footswitch config from adata/git/settings/keyd, reload keyd, show mapping.
# Moved from a/lib/pedal.c 2026-10-03 (aext; sh restored per IDEAS #130 — pure orchestration).
# Debian/Ubuntu name the binary keyd.rvaiya; status printed honestly — a fake OK after a failed
# reload sends you debugging the footswitch, not the install.
D=$HOME/a/adata/git/settings/keyd
ls "$D"/*.conf >/dev/null 2>&1 || { echo "x no keyd config in $D"; exit 1; }
sudo cp "$D"/*.conf /etc/keyd/ || { echo "x cp -> /etc/keyd failed"; exit 1; }
K=$(command -v keyd || command -v keyd.rvaiya)
ok=
[ -n "$K" ] && sudo "$K" reload && ok=1
if [ -n "$ok" ]; then echo "OK keyd reloaded: $D"
elif [ -n "$K" ]; then echo "x keyd reload FAILED - mapping not live"
else echo "x keyd not installed - mapping not live"; fi
lsusb 2>/dev/null | grep -i footswitch || echo "! footswitch not detected - plug it in"
echo "--- mapping ---"
cat "$D"/*.conf
[ -n "$ok" ]
