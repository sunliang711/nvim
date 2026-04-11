local enabled = PLUGINS.whichkey == nil or PLUGINS.whichkey.enabled ~= false

return {
    "folke/which-key.nvim",
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.whichkey").setup()
    end,
}
