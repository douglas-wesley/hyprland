#!/usr/bin/env bash
# Câmera Toggle OSD — descarrega/recarrega o módulo uvcvideo e mostra OSD
#
# Descarregar uvcvideo remove /dev/video*, bloqueando qualquer app de acessar
# a câmera a nível de kernel. Recarregar restaura o acesso.
# Requer: /etc/sudoers.d/camera-toggle com NOPASSWD para modprobe ±r uvcvideo

if lsmod | grep -q "^uvcvideo"; then
    sudo modprobe -r uvcvideo
    swayosd-client --custom-icon "camera-disabled-symbolic" --custom-message "Câmera Off"
else
    sudo modprobe uvcvideo
    swayosd-client --custom-icon "camera-web-symbolic" --custom-message "Câmera On"
fi
