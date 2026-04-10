return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = false,
    keys = {
        { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "close all to the left" },
        { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "close all to the right" },
        { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "close all other tabs" },
        { "<leader>bc", "<cmd>BufferLinePickClose<cr>", desc = "pick buffer to close" },
        { "<leader>bd", "<cmd>bdelete<cr>", desc = "close current buffer" },
        { "<leader>bp", "<cmd>BufferLineCyclePrev<cr>", desc = "previous" },
        { "<leader>bn", "<cmd>BufferLineCycleNext<cr>", desc = "next" },
        { "<leader>bb", "<cmd>BufferLineCyclePrev<cr>", desc = "previous" },
        { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "jump" },
    },
    config = function()
        require("plugin-configs.bufferline").setup()
    end,
}
