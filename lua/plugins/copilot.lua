return {
    {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end,
        enabled = PLUGINS.copilot.enabled,
        cond = PLUGINS.copilot.enabled,
    },
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
            if PLUGINS.copilot.http_proxy ~= nil and PLUGINS.copilot.http_proxy ~= "" then
                vim.notify("PRoxy not empty")
                vim.g.copilot_proxy = PLUGINS.copilot.http_proxy
            end
            require("plugin-configs.copilot").setup()
        end,
        enabled = PLUGINS.copilot.enabled,
        cond = PLUGINS.copilot.enabled,
    },
}
