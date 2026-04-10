return {
    "glepnir/lspsaga.nvim",
    branch = "main",
    enabled = PLUGINS.lsp.enabled and PLUGINS.lsp.saga,
    cond = PLUGINS.lsp.enabled and PLUGINS.lsp.saga,
    config = function()
        require("plugin-configs.lsp.lspsaga").setup()
    end,
}
