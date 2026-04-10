return {
    "williamboman/mason.nvim",
    enabled = PLUGINS.lsp.enabled and PLUGINS.lsp.mason,
    cond = PLUGINS.lsp.enabled and PLUGINS.lsp.mason,
    config = function()
        require("plugin-configs.lsp.mason").setup()
    end,
}
