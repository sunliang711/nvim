return {

    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    config = function()
        require("plugin-configs.hop").setup()
    end,
}
