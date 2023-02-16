local M = {}

function M.setup()
    local status, fidget = pcall(require, "fidget")
    if not status then
        return
    end

    fidget.setup()
end

return M
