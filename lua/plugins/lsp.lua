return {
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            -- cmp 关闭时不要加载补全能力桥接插件
            enabled = PLUGINS.cmp.enabled,
            cond = PLUGINS.cmp.enabled,
        },
    },
    enabled = PLUGINS.lsp.enabled,
    cond = PLUGINS.lsp.enabled,
    config = function()
        require("plugin-configs.lsp.handlers").setup()
        require("plugin-configs.lsp.servers").setup()
    end,
}
