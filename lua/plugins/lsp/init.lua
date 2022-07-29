local M = {}

function M.setup()
    require("plugins.lsp.lsp-signature")
    require("plugins.lsp.lsp-installer")
    require("plugins.lsp.handlers").setup()
    require("plugins.lsp.lspsaga").setup()

    -- TODO not work
    -- require("plugins.lsp.null-ls").setup()

    -- reference handlers.lua line 13
    -- require("plugins.lsp.autoformat").autoformat()
end

return M
