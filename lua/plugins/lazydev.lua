local enabled = PLUGINS.lazydev == nil or PLUGINS.lazydev.enabled ~= false

return {
    "folke/lazydev.nvim",
    ft = "lua",
    enabled = enabled,
    cond = enabled,
    opts = {
        library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
        integrations = {
            cmp = false,
        },
    },
}
