return {
    "echasnovski/mini.icons",
    dependencies = {},
    version='*',
    -- enabled = PLUGINS.nvim_cmp.enabled,
    -- cond = PLUGINS.nvim_cmp.enabled,
    config = function()
        require("plugin-configs.miniicons").setup()
    end,
}
