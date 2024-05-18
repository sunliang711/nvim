return {

    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "RRethy/nvim-treesitter-endwise",
        "windwp/nvim-ts-autotag",
    },
    enabled = PLUGINS.treesitter.enabled,
    cond = PLUGINS.treesitter.enabled,
    config = function()
        require("plugin-configs.treesitter").setup()
    end,
}
