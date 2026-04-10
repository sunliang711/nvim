return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    lazy = false,
    keys = {
        { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics" },
        { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
        { "<leader>xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols" },
    },
    enabled = PLUGINS.trouble.enabled,
    cond = PLUGINS.trouble.enabled,
    config = function()
        require("plugin-configs.trouble").setup()
    end,
}
