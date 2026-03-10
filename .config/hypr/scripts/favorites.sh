#!/bin/bash
# Lista de apps favoritos (edite conforme necessário)
FAVORITES=(
  "firefox.desktop"
  "kitty.desktop"
  "code.desktop"
  "discord.desktop"
  "spotify.desktop"
  "obsidian.desktop"
  "nemo.desktop"
  "steam.desktop"
  "idea.desktop"
  "com.obsproject.Studio.desktop"
  "gimp.desktop"
  "mpv.desktop"
  "org.pwmt.zathura.desktop"
  "libreoffice-writer.desktop"
  "libreoffice-calc.desktop"
  "libreoffice-impress.desktop"
  "libreoffice-draw.desktop"
  "libreoffice-math.desktop"
  "libreoffice-base.desktop"
  "mpv"
)
# Diretórios de aplicativos
APP_DIRS=(
  "/usr/share/applications"
  "$HOME/.local/share/applications"
)
# Função para obter informações do .desktop
get_app_info() {
  local desktop_file="$1"
  local name=""
  local exec_cmd=""
  local icon=""

  for dir in "${APP_DIRS[@]}"; do
    if [[ -f "$dir/$desktop_file" ]]; then
      name=$(grep -m1 "^Name=" "$dir/$desktop_file" | cut -d= -f2)
      exec_cmd=$(grep -m1 "^Exec=" "$dir/$desktop_file" | cut -d= -f2 | sed 's/ %[a-zA-Z]//g')
      icon=$(grep -m1 "^Icon=" "$dir/$desktop_file" | cut -d= -f2)
      echo -e "$name\x00icon\x1f$icon\x00info\x1f$exec_cmd"
      return
    fi
  done
}
# Se um argumento foi passado, executar o app selecionado
if [[ -n "$ROFI_INFO" ]]; then
  exec $ROFI_INFO &
  exit 0
fi
# Listar apps favoritos
for app in "${FAVORITES[@]}"; do
  get_app_info "$app"
done
