return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    enabled = PLUGINS.trouble.enabled,
    cond = PLUGINS.trouble.enabled,
    config = function()
        require("plugin-configs.trouble").setup()
    end,
}
