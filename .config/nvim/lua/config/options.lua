-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spelllang = { "en", "es" }
vim.opt.spell = true

-- Actualizar el linter y LSP en tiempo real (Modo Insertar)
vim.diagnostic.config({
    update_in_insert = true,
})
