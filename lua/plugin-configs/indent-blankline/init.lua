local M = {}

function M.setup()
    local status_ok, indent = pcall(require, "ibl")
    if not status_ok then
        return
    end

    indent.setup({})

    -- vim.notify("load ibl")
end

return M
