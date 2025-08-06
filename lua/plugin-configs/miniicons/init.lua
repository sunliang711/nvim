local M = {}

function M.setup()
    local status_ok, miniicons = pcall(require, "mini.icons")
    if not status_ok then
        return
    end

end

return M
