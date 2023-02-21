return {
    "ellisonleao/gruvbox.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    config = function()
        require("plugin-configs.colorscheme").setup()
    end,
}
