local use_lspsaga = PLUGINS.lsp.enabled and PLUGINS.lsp.saga
local use_telescope = PLUGINS.telescope == nil or PLUGINS.telescope.enabled ~= false

local keys = {
    {
        "<leader>la",
        use_lspsaga and "<cmd>Lspsaga code_action<cr>" or "<cmd>lua vim.lsp.buf.code_action()<cr>",
        desc = "Code Action",
    },
    {
        "<leader>lf",
        use_lspsaga and "<cmd>Lspsaga finder<cr>"
            or (use_telescope and "<cmd>Telescope lsp_definitions<cr>" or "<cmd>lua vim.lsp.buf.definition()<cr>"),
        desc = "Finder",
    },
    { "<leader>li", "<cmd>LspInfo<cr>", desc = "Info" },
    {
        "<leader>lj",
        "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>",
        desc = "Next Diagnostic",
    },
    {
        "<leader>lk",
        "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<cr>",
        desc = "Prev Diagnostic",
    },
    { "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<cr>", desc = "CodeLens Action" },
    {
        "<leader>lo",
        use_lspsaga and "<cmd>Lspsaga outline<cr>"
            or (use_telescope and "<cmd>Telescope lsp_document_symbols<cr>" or "<cmd>lua vim.lsp.buf.document_symbol()<cr>"),
        desc = "Outline",
    },
    { "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<cr>", desc = "Quickfix" },
    {
        "<leader>lr",
        use_lspsaga and "<cmd>Lspsaga rename<cr>" or "<cmd>lua vim.lsp.buf.rename()<cr>",
        desc = "Rename",
    },
    {
        "<leader>lR",
        use_telescope and "<cmd>Telescope lsp_references<cr>" or "<cmd>lua vim.lsp.buf.references()<cr>",
        desc = "References",
    },
    {
        "<leader>ls",
        use_telescope and "<cmd>Telescope lsp_document_symbols<cr>" or "<cmd>lua vim.lsp.buf.document_symbol()<cr>",
        desc = "Document Symbols",
    },
}

if PLUGINS.lsp.mason then
    table.insert(keys, { "<leader>lI", "<cmd>Mason<cr>", desc = "Mason" })
end

if use_lspsaga then
    table.insert(keys, { "<leader>lt", "<cmd>Lspsaga term_toggle<cr>", desc = "Terminal" })
    table.insert(keys, { "<leader>lw", "<cmd>Lspsaga winbar_toggle<cr>", desc = "Winbar" })
end

if use_telescope then
    table.insert(keys, { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" })
end

return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        {
            "hrsh7th/cmp-nvim-lsp",
            -- cmp 关闭时不要加载补全能力桥接插件
            enabled = PLUGINS.cmp.enabled,
            cond = PLUGINS.cmp.enabled,
        },
    },
    enabled = PLUGINS.lsp.enabled,
    cond = PLUGINS.lsp.enabled,
    keys = keys,
    config = function()
        require("plugin-configs.lsp.handlers").setup()
        require("plugin-configs.lsp.servers").setup()
    end,
}
