return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
        { "<leader>;", "<cmd>Alpha<cr>", desc = "Dashboard" },
    },
    config = function()
        require("plugin-configs.alpha").setup()
    end,
}
