local enabled = PLUGINS.surround == nil or PLUGINS.surround.enabled ~= false

return {
    "tpope/vim-surround",
    dependencies = {
        "tpope/vim-repeat",
    },
    enabled = enabled,
    cond = enabled,
    config = function()
        require("plugin-configs.surround").setup()
    end,
}
