return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "saadparwaiz1/cmp_luasnip",
        "L3MON4D3/LuaSnip", --snippet engine
        "rafamadriz/friendly-snippets",
    },
    enabled = PLUGINS.nvim_cmp.enabled,
    cond = PLUGINS.nvim_cmp.enabled,
    config = function()
        require("plugin-configs.cmp").setup()
    end,
}
