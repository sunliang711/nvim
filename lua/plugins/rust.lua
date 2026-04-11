local enabled = PLUGINS.rust == nil or PLUGINS.rust.enabled ~= false

return {

    "rust-lang/rust.vim",
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.rust").setup()
    end,
}
