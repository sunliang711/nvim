return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("plugin-configs.alpha").setup()
    end,
}
