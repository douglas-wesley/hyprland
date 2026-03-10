#!/bin/bash

# Diretório onde estão seus wallpapers
# Certifique-se que o caminho está correto e sem erros de digitação
DIR="$HOME/Imagens/Wallpapers/"

# Tempo entre trocas (em segundos)
INTERVAL=300

# --- VERIFICAÇÃO E INICIALIZAÇÃO DO DAEMON ---
# Verifica se o swww-daemon já está rodando. Se não estiver, inicia.
if ! pgrep -x swww-daemon > /dev/null; then
    echo "Iniciando swww-daemon..."
    swww-daemon & 
    sleep 1 # Espera 1 segundo para o socket ser criado antes de continuar
fi

while true; do
    # Seleciona uma imagem aleatória da pasta
    # O 'find' procura arquivos (-type f) dentro do diretório
    WALLPAPER=$(find "$DIR" -type f | shuf -n 1)

    # Se não encontrar wallpapers, avisa e espera um pouco para não travar o PC
    if [ -z "$WALLPAPER" ]; then
        echo "Nenhum wallpaper encontrado em $DIR"
        sleep 60
        continue
    fi
    
    # Aplica o wallpaper com transição
    # --transition-type random: Escolhe um efeito aleatório a cada troca
    swww img "$WALLPAPER" \
        --transition-type random \
        --transition-step 90 \
        --transition-fps 60 \
        --transition-duration 2

    # Aguarda o tempo definido antes da próxima troca
    sleep $INTERVAL
done
