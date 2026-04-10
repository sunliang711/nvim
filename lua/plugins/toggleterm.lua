return {
    "akinsho/toggleterm.nvim",
    lazy = false,
    keys = {
        { "<C-t>", "<cmd>ToggleTerm size=30 <cr>", mode = { "n", "t" }, desc = "Toggle Terminal" },
        { "<leader>Tt", "<cmd>ToggleTerm direction=float<cr>", desc = "Float" },
        { "<leader>Th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "Horizontal Terminal" },
        { "<leader>Tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical Terminal" },
        { "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", desc = "Lazygit" },
    },
    config = function()
        require("plugin-configs.toggleterm").setup()
    end,
}
