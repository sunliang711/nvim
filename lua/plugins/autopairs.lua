local enabled = PLUGINS.autopairs == nil or PLUGINS.autopairs.enabled ~= false

return {
    "windwp/nvim-autopairs",
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.autopairs").setup()
    end,
}
