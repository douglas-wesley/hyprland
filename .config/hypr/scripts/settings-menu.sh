#!/bin/bash

# Adicione "Impressoras" na lista de opções
options="Monitores\nÁudio\nBluetooth\nRede\nImpressoras\nWallpaper\nTemas"

# Escolha via Rofi
chosen=$(echo -e "$options" | rofi -dmenu -i -p "Configurações")

case "$chosen" in
"Monitores") nwg-displays ;;
"Áudio") pavucontrol ;;
"Bluetooth") blueman-manager ;;
"Rede") nm-connection-editor ;;
"Impressoras") system-config-printer ;; # <--- NOVA LINHA AQUI
"Wallpaper") waypaper ;;
"Temas") nwg-look ;;
esac
