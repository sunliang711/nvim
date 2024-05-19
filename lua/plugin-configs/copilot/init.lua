local M = {}

function M.setup()
    local status, copilot = pcall(require, "copilot")
    if not status then
        vim.notify("load copilot failed")
        return
    end

    copilot.setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
    })
end

return M
