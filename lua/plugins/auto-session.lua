local enabled = PLUGINS.auto_session == nil or PLUGINS.auto_session.enabled ~= false

return {
    "rmagatti/auto-session",
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.auto-session").setup()
    end,
}
