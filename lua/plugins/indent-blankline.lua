return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    config = function()
        require("plugin-configs.indent-blankline").setup()
    end,
}
