return {
    "lewis6991/impatient.nvim",
    priority = 30,
    enabled = vim.fn.has("nvim-0.9") == 0,
    cond = vim.fn.has("nvim-0.9") == 0,
    config = function()
        require("plugin-configs.impatient").setup()
    end,
}
