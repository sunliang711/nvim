local enabled = PLUGINS.neoscroll == nil or PLUGINS.neoscroll.enabled ~= false

return {
    "karb94/neoscroll.nvim",
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.neoscroll").setup()
    end,
}
