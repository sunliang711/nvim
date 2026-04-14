local enabled = PLUGINS.telescope == nil or PLUGINS.telescope.enabled ~= false

return {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false,
    keys = {
        {
            "<leader>fF",
            function()
                require("functions").telescope_find_files()
            end,
            desc = "Find Files (With Previewer)",
        },
        {
            "<leader>ff",
            function()
                require("functions").telescope_find_files(require("telescope.themes").get_dropdown({ previewer = false }))
            end,
            desc = "Find Files",
        },
        {
            "<leader>ft",
            function()
                require("functions").telescope_live_grep(require("telescope.themes").get_ivy())
            end,
            desc = "Find Text",
        },
        { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffer List" },
        { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent File" },
        { "<leader>fc", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>tr", "<cmd>Telescope registers<cr>", desc = "Registers" },
        { "<leader>tk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
        { "<leader>th", "<cmd>Telescope command_history<cr>", desc = "Command History" },
        { "<leader>tc", "<cmd>Telescope commands<cr>", desc = "Commands" },
        { "<leader>tm", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
        { "<leader>tC", "<cmd>Telescope colorscheme<cr>", desc = "Colorscheme" },
        { "<leader>tl", "<cmd>Telescope resume<cr>", desc = "Last Search" },
        { "<leader>t?", "<cmd>Telescope help_tags<cr>", desc = "Help" },
        { "<leader>go", "<cmd>Telescope git_status<cr>", desc = "Open changed file" },
        { "<leader>gb", "<cmd>Telescope git_branches<cr>", desc = "Checkout branch" },
        { "<leader>gc", "<cmd>Telescope git_commits<cr>", desc = "Checkout commit" },
    },
    config = function()
        require("plugin-configs.telescope").setup()
    end,
    enabled = enabled,
    cond = enabled,
}
