-- config lsp installer
local M = {}

function M.setup()
    local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
    if not status_ok then
        return
    end

    mason_lspconfig.setup({
        ensure_installed = {
            -- "clangd",
            "rust_analyzer",
            "pyright",
            "ts_ls",
            "gopls",
            "lua_ls",
            "html",
            "cssls",
            "jsonls",
            "bashls",
            "solidity",
            "solc",
            "emmet_ls",
        },
        automatic_installation = true,
    })
end

return M
