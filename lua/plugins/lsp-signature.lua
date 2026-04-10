return {
    "ray-x/lsp_signature.nvim",
    enabled = PLUGINS.lsp.enabled and PLUGINS.lsp.signature,
    cond = PLUGINS.lsp.enabled and PLUGINS.lsp.signature,
    config = function()
        require("plugin-configs.lsp.lsp-signature")
    end,
}
