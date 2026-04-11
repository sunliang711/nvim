local enabled = PLUGINS.mini_icons == nil or PLUGINS.mini_icons.enabled ~= false

return {
    "echasnovski/mini.icons",
    dependencies = {},
    version='*',
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.miniicons").setup()
    end,
}
