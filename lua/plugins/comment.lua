return {
    "numToStr/Comment.nvim",
    lazy = false,
    keys = {
        {
            "<leader>/",
            '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
            mode = "n",
            desc = "Comment",
        },
        {
            "<leader>/",
            '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
            mode = "v",
            desc = "Comment",
        },
    },
    config = function()
        require("plugin-configs.comment").setup()
    end,
}
