#!/bin/bash

# Lista de apps favoritos (edite conforme necessário)
FAVORITES=(
    # Navegador
    "firefox.desktop"
    
    # Terminais e Editores
    "kitty.desktop"
    "code.desktop"
    "nvim.desktop"
    "vim.desktop"
    "idea.desktop"
    
    # Comunicação e Mídia
    "discord.desktop"
    "spotify.desktop"
    "mpv.desktop"
    "io.github.celluloid_player.Celluloid.desktop"
    "com.obsproject.Studio.desktop"
    
    # Produtividade
    "obsidian.desktop"
    "nemo.desktop"
    "org.pwmt.zathura.desktop"
    "org.kde.okular.desktop"
    "org.gnome.FileRoller.desktop"
    
    # LibreOffice
    "libreoffice-writer.desktop"
    "libreoffice-calc.desktop"
    "libreoffice-impress.desktop"
    "libreoffice-draw.desktop"
    "libreoffice-base.desktop"
    "libreoffice-math.desktop"
    
    # Gráficos
    "gimp.desktop"
    
    # Jogos
    "steam.desktop"
    
    # Sistema
    "btop.desktop"
    "blueman-manager.desktop"
    "org.pulseaudio.pavucontrol.desktop"
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

# Se um argumento foi passado, executar o app/arquivo selecionado
if [[ -n "$ROFI_INFO" ]]; then
    exec $ROFI_INFO &
    exit 0
fi

# Listar apps favoritos
for app in "${FAVORITES[@]}"; do
    get_app_info "$app"
done
