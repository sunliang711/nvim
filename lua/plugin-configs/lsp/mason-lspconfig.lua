-- config lsp installer
local status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
    return
end

-- config lspconfig
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
    "solidity",
    "solc", -- solidity needs solc
    -- 'solang',
    "emmet_ls",
}

mason_lspconfig.setup({
    ensure_installed = servers,
    automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("plugin-configs.lsp.handlers").on_attach,
        capabilities = require("plugin-configs.lsp.handlers").capabilities,
    }

    server = vim.split(server, "@")[1]

    -- if server == "jsonls" then
    --     local jsonls_opts = require "plugins.lsp.settings.jsonls"
    --     opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
    -- end
    --
    -- if server == "yamlls" then
    --     local yamlls_opts = require "plugins.lsp.settings.yamlls"
    --     opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
    -- end
    --
    -- if server == "sumneko_lua" then
    --     local sumneko_opts = require "plugins.lsp.settings.sumneko_lua"
    --     opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    --
    --     local l_status_ok, lua_dev = pcall(require, "lua-dev")
    --     if l_status_ok then
    --         -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    --         local luadev = lua_dev.setup {
    --             --   -- add any options here, or leave empty to use the default settings
    --             -- lspconfig = opts,
    --             lspconfig = {
    --                 on_attach = opts.on_attach,
    --                 capabilities = opts.capabilities,
    --                 --   -- settings = opts.settings,
    --             },
    --         }
    --         lspconfig.sumneko_lua.setup(luadev)
    --     end
    --     goto continue
    -- end
    --
    if server == "tsserver" then
        local tsserver_opts = require("plugin-configs.lsp.settings.tsserver")
        opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
        -- debug
        -- print("tsserver opts:" .. vim.inspect(opts))
    end
    --
    -- if server == "pyright" then
    --     local pyright_opts = require "plugins.lsp.settings.pyright"
    --     opts = vim.tbl_deep_extend("force", pyright_opts, opts)
    -- end
    --
    -- if server == "solc" then
    --     local solc_opts = require "plugins.lsp.settings.solc"
    --     opts = vim.tbl_deep_extend("force", solc_opts, opts)
    -- end
    --
    -- if server == "emmet_ls" then
    --     local emmet_ls_opts = require "plugins.lsp.settings.emmet_ls"
    --     opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
    -- end

    -- if server == "zk" then
    --     local zk_opts = require "plugins.lsp.settings.zk"
    --     opts = vim.tbl_deep_extend("force", zk_opts, opts)
    -- end
    --
    -- if server == "jdtls" then
    --     goto continue
    -- end

    if server == "rust_analyzer" then
        local rust_opts = require("plugin-configs.lsp.settings.rust")
        opts = vim.tbl_deep_extend("force", rust_opts, opts)
        local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
        if not rust_tools_status_ok then
            return
        end

        rust_tools.setup(opts)
        goto continue
    end

    if server == "lua_ls" then
        local lua_opts = require("plugin-configs.lsp.settings.lua_ls")
        opts = vim.tbl_deep_extend("force", lua_opts, opts)
        -- -- debug
        -- print("lua_ls opts: " .. vim.inspect(opts))
    end

    -- debug
    -- vim.notify("Config lsp for: " .. server)
    lspconfig[server].setup(opts)
    ::continue::
end
