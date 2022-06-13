local C = require("plugins.pluginloader")
local M = {}
function M.load_p_config(plugin)
    if C[plugin] then
        if C.debug then
            vim.notify("load plugins." .. plugin)
        end
        require("plugins." .. plugin)
    end
end

return M
