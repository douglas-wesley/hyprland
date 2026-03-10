#!/usr/bin/env bash

set -e

echo "🚀 Preparando o ambiente de Douglas..."

# 1. Instalação do Yay
if ! command -v yay &>/dev/null; then
  echo "📦 Instalando o yay..."
  sudo pacman -S --needed base-devel git
  git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm
  cd .. && rm -rf yay
fi

# 2. Instalação de Pacotes (Resumo das suas listas)
echo "🛠️ Instalando pacotes base e interface..."
PKGS=(
  hyprland waybar rofi kitty swaync nwg-look nwg-displays starship
  zsh zsh-autosuggestions zsh-syntax-highlighting
  ttf-jetbrains-mono-nerd noto-fonts-emoji
  neovim docker docker-compose postgresql-libs
)
sudo pacman -S --needed --noconfirm "${PKGS[@]}"

# 3. Configuração do Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "🐚 Instalando Oh My Zsh..."
  # A flag --unattended evita que o script mude seu shell e pare a execução aqui
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 4. Restauração dos Dotfiles (Bare Repo)
echo "📁 Sincronizando dotfiles do GitHub..."
DOTFILES_REPO="git@github.com:douglas-wesley/hyprland.git"

# Evita conflitos se o install.sh do OMZ criou um .zshrc padrão
[ -f "$HOME/.zshrc" ] && mv "$HOME/.zshrc" "$HOME/.zshrc.bak"

git clone --bare "$DOTFILES_REPO" "$HOME/.dotfiles"

function config {
  /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
}

# Força o checkout para garantir que suas configs sobrescrevam os padrões
config checkout -f
config config --local status.showUntrackedFiles no

# 5. Finalização
echo "⚓ Mudando shell padrão para Zsh..."
chsh -s $(which zsh)

echo "✅ Tudo pronto! Basta deslogar e logar novamente."
