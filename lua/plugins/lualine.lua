local enabled = PLUGINS.lualine == nil or PLUGINS.lualine.enabled ~= false

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.lualine").setup()
    end,
}
