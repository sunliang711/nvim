return {
    "tpope/vim-surround",
    dependencies = {
        "tpope/vim-repeat",
    },
    config = function()
        require("plugin-configs.surround").setup()
    end,
}
