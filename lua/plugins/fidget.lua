return {
    "j-hui/fidget.nvim",
    tag = "legacy",
    enabled = PLUGINS.lsp.enabled and PLUGINS.lsp.fidget,
    cond = PLUGINS.lsp.enabled and PLUGINS.lsp.fidget,
    config = function()
        require("plugin-configs.lsp.fidget").setup()
    end,
}
