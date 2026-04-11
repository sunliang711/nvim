local enabled = PLUGINS.comment == nil or PLUGINS.comment.enabled ~= false

return {
    "numToStr/Comment.nvim",
    lazy = false,
    keys = {
        {
            "<leader>/",
            "<Plug>(comment_toggle_linewise_current)",
            mode = "n",
            desc = "Comment",
        },
        {
            "<leader>/",
            "<Plug>(comment_toggle_linewise_visual)",
            mode = "x",
            desc = "Comment",
        },
    },
    config = function()
        require("plugin-configs.comment").setup()
    end,
    enabled = enabled,
    cond = enabled,
}
