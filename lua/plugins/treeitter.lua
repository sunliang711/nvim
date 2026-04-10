return {

    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        {
            "RRethy/nvim-treesitter-endwise",
            enabled = PLUGINS.treesitter.enabled and PLUGINS.treesitter.endwise,
            cond = PLUGINS.treesitter.enabled and PLUGINS.treesitter.endwise,
        },
        {
            "windwp/nvim-ts-autotag",
            enabled = PLUGINS.treesitter.enabled and PLUGINS.treesitter.autotag,
            cond = PLUGINS.treesitter.enabled and PLUGINS.treesitter.autotag,
        },
    },
    enabled = PLUGINS.treesitter.enabled,
    cond = PLUGINS.treesitter.enabled,
    config = function()
        require("plugin-configs.treesitter").setup()
    end,
}
