return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("plugin-configs.trouble").setup()
    end,
}
