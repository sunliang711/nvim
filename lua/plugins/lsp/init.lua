local M = {}

function M.setup()
    require("plugins.lsp.lsp-signature")
    require("plugins.lsp.lsp-installer")
    require("plugins.lsp.handlers").setup()
    -- require("plugins.lsp.autoformat").autoformat()
end

return M
