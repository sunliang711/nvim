return {
    "goolord/alpha-nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    config = function()
        require("plugin-configs.alpha").setup()
    end,
}
