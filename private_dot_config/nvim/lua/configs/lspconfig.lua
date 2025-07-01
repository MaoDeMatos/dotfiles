require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "ts_ls", "bashls", "ruff" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

-- local on_attach = require("plugins.configs.lspconfig").on_attach
-- local capabilities = require("plugins.configs.lspconfig").capabilities
-- local lspconfig = require "lspconfig"
--
-- lspconfig.bashls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = { "sh", "bash", "zsh" }, -- optional
-- }
