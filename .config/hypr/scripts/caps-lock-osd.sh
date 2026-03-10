#!/usr/bin/env bash
# Caps Lock OSD — mostra "Caps Lock On" ou "Caps Lock Off"
#
# Usa hyprctl como fonte de verdade: o estado lido já é o NOVO estado
# (Hyprland aplica o toggle antes de executar o bind).
# flock garante execução exclusiva sem race condition ao apertar rápido.

exec 9>/tmp/caps-lock-osd.lock
flock -n 9 || exit 0

CAPS_STATE=$(hyprctl devices -j 2>/dev/null \
    | python3 -c "
import json, sys
devs = json.load(sys.stdin)
for kb in devs.get('keyboards', []):
    if kb.get('main'):
        print('1' if kb.get('capsLock') else '0')
        break
" 2>/dev/null)

if [ "$CAPS_STATE" = "1" ]; then
    swayosd-client --custom-icon "input-caps-on-symbolic" --custom-message "Caps Lock On"
else
    swayosd-client --custom-icon "input-caps-on-symbolic" --custom-message "Caps Lock Off"
fi
