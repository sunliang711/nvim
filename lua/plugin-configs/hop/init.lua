local M = {}

function M.setup()
    local status_ok, hop = pcall(require, "hop")
    if not status_ok then
        return
    end

    hop.setup()
end

return M
