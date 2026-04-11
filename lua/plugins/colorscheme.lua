local enabled = PLUGINS.colorscheme == nil or PLUGINS.colorscheme.enabled ~= false

return {
    "ellisonleao/gruvbox.nvim",
    dependencies = { "rktjmp/lush.nvim" },
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.colorscheme").setup()
    end,
}
