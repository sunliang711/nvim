return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    keys = {
        {
            "<leader>gj",
            function()
                require("gitsigns").next_hunk()
            end,
            desc = "Next Hunk",
        },
        {
            "<leader>gk",
            function()
                require("gitsigns").prev_hunk()
            end,
            desc = "Prev Hunk",
        },
        {
            "<leader>gp",
            function()
                require("gitsigns").preview_hunk()
            end,
            desc = "Preview Hunk",
        },
        {
            "<leader>gr",
            function()
                require("gitsigns").reset_hunk()
            end,
            desc = "Reset Hunk",
        },
        {
            "<leader>gR",
            function()
                require("gitsigns").reset_buffer()
            end,
            desc = "Reset Buffer",
        },
        {
            "<leader>gs",
            function()
                require("gitsigns").stage_hunk()
            end,
            desc = "Stage Hunk",
        },
        {
            "<leader>gu",
            function()
                require("gitsigns").undo_stage_hunk()
            end,
            desc = "Undo Stage Hunk",
        },
    },
    config = function()
        require("plugin-configs.gitsigns").setup()
    end,
}
