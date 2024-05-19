return {
    "neovim/nvim-lspconfig",
    dependencies = {
        { "williamboman/mason.nvim" },
        { "williamboman/mason-lspconfig.nvim" },
        { "neovim/nvim-lspconfig" },
        { "hrsh7th/cmp-nvim-lsp" },
        -- lsp source for nvim-cmp
        { "ray-x/lsp_signature.nvim" },
        { "RRethy/vim-illuminate" },
        { "SmiteshP/nvim-navic" },
        {
            "glepnir/lspsaga.nvim",
            branch = "main",
        },
        {
            "simrat39/rust-tools.nvim",
        },
        {
            "rust-lang/rust.vim",
        },
        {
            "jose-elias-alvarez/null-ls.nvim",
        },
        {
            "j-hui/fidget.nvim",
            tag = "legacy",
        },
    },
    enabled = PLUGINS.lsp.enabled,
    cond = PLUGINS.lsp.enabled,
    config = function()
        require("plugin-configs.lsp").setup()
    end,
}
