#!/usr/bin/env bash
# Microfone OSD — faz o mute-toggle e mostra "Microfone On" ou "Microfone Off"
#
# wpctl faz o toggle de forma síncrona, então o estado lido logo após
# já é o novo estado correto. swayosd-client exibe apenas o OSD visual.

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

MUTE_STATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ 2>/dev/null | grep -c "MUTED")

if [ "$MUTE_STATE" = "1" ]; then
    swayosd-client --custom-icon "microphone-disabled-symbolic" --custom-message "Microfone Off"
else
    swayosd-client --custom-icon "audio-input-microphone-symbolic" --custom-message "Microfone On"
fi
