local enabled = PLUGINS.alpha == nil or PLUGINS.alpha.enabled ~= false

return {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    keys = {
        { "<leader>cd", "<cmd>Alpha<cr>", desc = "Dashboard" },
    },
    config = function()
        require("plugin-configs.alpha").setup()
    end,
    enabled = enabled,
    cond = enabled,
}
