local M = {}

function M.setup()
    require("plugins.lsp.lsp-signature")
    -- lsp-installer replaced by mason
    -- require("plugins.lsp.lsp-installer")
    require("plugins.lsp.mason").setup()
    require("plugins.lsp.mason-lspconfig")
    require("plugins.lsp.handlers").setup()
    require("plugins.lsp.lspsaga").setup()
    -- require("plugins.lsp.rust-tools").setup()

    -- TODO not work
    require("plugins.lsp.null-ls").setup()

    -- reference handlers.lua line 13
    -- require("plugins.lsp.autoformat").autoformat()
end

return M
