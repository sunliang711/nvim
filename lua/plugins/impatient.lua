return {
    "lewis6991/impatient.nvim",
    priority = 30,
    config = function()
        require("plugin-configs.impatient").setup()
    end,
}
