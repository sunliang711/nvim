local M = {}

function M.setup()
    local F = require "functions"

    -- load plugin manager
    require "plugins.packer".setup()

    F.load_plugins()
end

return M
