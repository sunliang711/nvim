local enabled = PLUGINS.indent_blankline == nil or PLUGINS.indent_blankline.enabled ~= false

return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {},
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.indent-blankline").setup()
    end,
}
