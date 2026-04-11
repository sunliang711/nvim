local enabled = PLUGINS.notify == nil or PLUGINS.notify.enabled ~= false

return {

    "rcarriga/nvim-notify",
    priority = 35,
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.notify").setup()
    end,
}
