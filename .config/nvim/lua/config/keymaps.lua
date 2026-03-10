-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Atalho: Ctrl + j
-- Função: Abrir e Fechar o Terminal (Estilo VS Code)

local map = vim.keymap.set

-- 1. No modo Normal (quando você está navegando no código)
map("n", "<C-//>", function()
  -- Tenta usar o Snacks (novo padrão do LazyVim) ou fallback para o antigo
  if package.loaded["snacks"] then
    Snacks.terminal(nil, { win = { position = "bottom", height = 0.3 } })
  else
    -- Caso sua versão do LazyVim seja mais antiga
    require("lazyvim.util").terminal(nil, { border = "rounded" })
  end
end, { desc = "Toggle Terminal" })

-- 2. No modo Terminal (quando você está DIGITANDO no terminal)
-- Isso é crucial: sem isso, o Ctrl+j digita uma quebra de linha em vez de fechar
map("t", "<C-//>", "<cmd>close<cr>", { desc = "Fechar Terminal" })
