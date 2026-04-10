return {

    "phaazon/hop.nvim",
    branch = "v2", -- optional but strongly recommended
    lazy = false,
    keys = {
        { "gw", "<cmd>HopWord<cr>", desc = "Hop Word" },
        { "gl", "<cmd>HopLine<cr>", desc = "Hop Line" },
        { "gp", "<cmd>HopPattern<cr>", desc = "Hop Pattern" },
    },
    config = function()
        require("plugin-configs.hop").setup()
    end,
}
