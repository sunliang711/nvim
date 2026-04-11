local M = {}

function M.setup()
    local servers = {
        -- "clangd",
        "rust_analyzer",
        "pyright",
        -- "tsserver",
        "ts_ls",
        "gopls",
        "lua_ls",
        "html",
        "cssls",
        -- "yamlls",
        "jsonls",
        "bashls",
        "solc", -- solidity files use solc
        -- 'solang',
        "emmet_ls",
    }

    local function enable_server(server, extra_opts)
        local opts = {
            on_attach = require("plugin-configs.lsp.handlers").on_attach,
            capabilities = require("plugin-configs.lsp.handlers").capabilities,
        }

        if extra_opts ~= nil then
            opts = vim.tbl_deep_extend("force", opts, extra_opts)
        end

        vim.lsp.config(server, opts)
        vim.lsp.enable(server)
    end

    for _, server in pairs(servers) do
        server = vim.split(server, "@")[1]
        local opts = nil

        if server == "ts_ls" then
            opts = require("plugin-configs.lsp.settings.tsserver")
        end

        if server == "rust_analyzer" then
            local rust_opts = require("plugin-configs.lsp.settings.rust")
            opts = rust_opts.server or {}
        end

        if server == "lua_ls" then
            opts = require("plugin-configs.lsp.settings.lua_ls")
        end

        if server == "solc" then
            opts = require("plugin-configs.lsp.settings.solc")
        end

        enable_server(server, opts)
    end
end

return M
