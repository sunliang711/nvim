return {
    "nvimtools/none-ls.nvim",
    enabled = PLUGINS.lsp.enabled and PLUGINS.lsp.none_ls,
    cond = PLUGINS.lsp.enabled and PLUGINS.lsp.none_ls,
    config = function()
        require("plugin-configs.lsp.null-ls").setup()
    end,
}
