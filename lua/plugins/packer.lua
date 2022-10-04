local M = {}

function M.setup()
    local PACKER_BOOTSTRAP = false

    local conf = {
        display = {
            open_fn = function()
                return require("packer.util").float { border = "rounded" }
            end,
        },
    }

    local function packer_init()
        local fn = vim.fn

        local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
        -- Automatically install packer
        if fn.empty(fn.glob(install_path)) > 0 then
            PACKER_BOOTSTRAP = fn.system {
                "git",
                "clone",
                "--depth",
                "1",
                "https://github.com/wbthomason/packer.nvim",
                install_path,
            }
            print "Installing packer, close and reopen Neovim after installation !!"
            vim.cmd [[packadd packer.nvim]]
        end
        -- Autocommand that reloads neovim whenever you save the packer.lua file
        -- vim.cmd [[
        --   augroup packer_user_config
        --     autocmd!
        --     autocmd BufWritePost packer.lua source <afile> | PackerSync
        --   augroup end
        -- ]]

    end

    local function plugins(use)
        use "wbthomason/packer.nvim" -- Have packer manage itself

        local C = require "functions".merge_settings()
        -- print(vim.inspect(C))
        for plugin_name, setting in pairs(C) do
            if type(setting) == "table" then
                if setting.enable then
                    if C.debug then
                        vim.notify("Pack load plugin " .. plugin_name)
                    end
                    use(setting.packer_use)
                end
            end
        end

        -- -- speed up loading lua modules in neovim
        -- use {
        --     "lewis6991/impatient.nvim",
        --     disable = not C["impatient"].enable
        -- }
        --
        -- use {
        --     'goolord/alpha-nvim',
        --     requires = { 'kyazdani42/nvim-web-devicons' },
        --     disable = not C["alpha"].enable
        -- }
        --
        -- -- use {
        -- --     "Mephistophiles/surround.nvim",
        -- --     disable = not C["surround"].enable
        -- -- }
        --
        -- use {
        --     {
        --         "tpope/vim-surround",
        --         disable = not C["surround"].enable
        --     },
        --     {
        --         "tpope/vim-repeat",
        --         disable = not C["surround"].enable
        --     }
        -- }
        -- -- use {
        -- --   "ur4ltz/surround.nvim",
        -- --   disable = not C["surround"].enable
        -- -- }
        --
        -- -- nvim tree
        -- use {
        --     'kyazdani42/nvim-tree.lua',
        --     requires = 'kyazdani42/nvim-web-devicons',
        --     disable = not C["nvimtree"].enable
        -- }
        --
        -- -- use "lukas-reineke/indent-blankline.nvim"
        --
        -- -- telescope
        -- use {
        --     'nvim-telescope/telescope.nvim',
        --     requires = { { 'nvim-lua/plenary.nvim' } },
        --     disable = not C["telescope"].enable
        -- }
        --
        -- -- comment
        -- use {
        --     "numToStr/Comment.nvim",
        --     disable = not C["comment"].enable
        -- }
        --
        -- -- git
        -- use {
        --     'lewis6991/gitsigns.nvim',
        --     disable = not C["gitsigns"].enable
        --     -- tag = 'release' -- To use the latest release
        -- }
        --
        -- use {
        --     'windwp/nvim-autopairs',
        --     disable = not C["autopairs"].enable
        -- }
        --
        -- -- terminal
        -- use {
        --     "akinsho/toggleterm.nvim",
        --     disable = not C["toggleterm"].enable
        -- }
        --
        -- -- colorscheme
        -- use "lunarvim/darkplus.nvim"
        -- use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }
        -- use { "sainnhe/everforest" }
        --
        -- -- bufferline
        -- use {
        --     'akinsho/bufferline.nvim',
        --     tag = "v2.*",
        --     requires = 'kyazdani42/nvim-web-devicons',
        --     disable = not C["bufferline"].enable
        --
        -- }
        -- -- lualine
        -- use {
        --     'nvim-lualine/lualine.nvim',
        --     requires = {
        --         { 'kyazdani42/nvim-web-devicons', opt = true },
        --         -- { 'SmiteshP/nvim-navic' },
        --     },
        --     disable = not C["lualine"].enable
        -- }
        -- use {
        --     'arkav/lualine-lsp-progress',
        --     disable = not C["lsp"].enable
        -- }
        --
        -- use {
        --     "rcarriga/nvim-notify",
        --     disable = not C["notify"].enable
        --
        -- }
        --
        -- -- neoscroll
        -- use {
        --     "karb94/neoscroll.nvim",
        --     disable = not C["neoscroll"].enable
        -- }
        --
        -- use {
        --     'phaazon/hop.nvim',
        --     branch = 'v1', -- optional but strongly recommended
        -- }
        --
        -- -- -- treesitter
        -- use {
        --     "nvim-treesitter/nvim-treesitter",
        --     run = ":TSUpdate",
        --     disable = not C["treesitter"].enable
        -- }
        --
        -- use {
        --     "RRethy/nvim-treesitter-endwise",
        --     disable = not C["treesitter"].enable
        -- }
        --
        -- use {
        --     "windwp/nvim-ts-autotag",
        --     disable = not C["treesitter"].enable
        -- }
        --
        -- -- cmp (completion)
        -- use {
        --     "hrsh7th/nvim-cmp",
        --     disable = not C["cmp"].enable
        -- }
        -- use {
        --     "hrsh7th/cmp-buffer",
        --     disable = not C["cmp"].enable
        -- }
        -- use {
        --     "hrsh7th/cmp-path",
        --     disable = not C["cmp"].enable
        -- }
        -- use {
        --     "hrsh7th/cmp-cmdline",
        --     disable = not C["cmp"].enable
        -- }
        -- use {
        --     "hrsh7th/cmp-nvim-lua",
        --     disable = not C["cmp"].enable
        -- }
        -- use {
        --     {
        --         'saadparwaiz1/cmp_luasnip',
        --         disable = not C["cmp"].enable
        --     },
        --     {
        --         "L3MON4D3/LuaSnip", --snippet engine
        --         disable = not C["cmp"].enable
        --     },
        --     {
        --         "rafamadriz/friendly-snippets",
        --         disable = not C["cmp"].enable
        --     },
        -- }
        -- -- use {
        -- --     "hrsh7th/cmp-nvim-lsp-signature-help",
        -- --     disable = not C["cmp"].enable
        -- -- }
        --
        -- use {
        --     "rust-lang/rust.vim",
        --     disable = not C["lsp"].enable
        -- }
        --
        -- -- lsp
        -- use {
        --     {
        --         "williamboman/mason.nvim",
        --         disable = not C["lsp"].enable
        --     },
        --     {
        --         "williamboman/mason-lspconfig.nvim",
        --         disalbe = not C["lsp"].enable
        --     },
        --     -- {
        --     --     "williamboman/nvim-lsp-installer",
        --     --     disable = not C["lsp"].enable
        --     -- },
        --     {
        --         "neovim/nvim-lspconfig",
        --         -- after = "nvim-lsp-installer",
        --         disable = not C["lsp"].enable
        --     },
        --     {
        --         "hrsh7th/cmp-nvim-lsp", -- lsp source for nvim-cmp
        --         disable = not C["lsp"].enable
        --     },
        --     {
        --         "ray-x/lsp_signature.nvim",
        --         disable = not C["lsp"].enable
        --     },
        --     {
        --         "RRethy/vim-illuminate",
        --         disable = not C["lsp"].enable
        --     },
        --     {
        --         "SmiteshP/nvim-navic",
        --         requires = {
        --             { "neovim/nvim-lspconfig" }
        --         },
        --         disable = not C["lsp"].enable
        --     },
        --     {
        --         "glepnir/lspsaga.nvim",
        --         branch = "main",
        --         disable = not C["lsp"].enable
        --     },
        --     {
        --         "simrat39/rust-tools.nvim",
        --         disable = not C["lsp"].enable
        --     },
        --     -- {
        --     --     "lvimuser/lsp-inlayhints.nvim",
        --     --     disable = not C["lsp"].enable
        --     -- },
        --
        --     -- {
        --     --     "jose-elias-alvarez/null-ls.nvim",
        --     --     requires = {
        --     --         { "nvim-lua/plenary.nvim" }
        --     --     },
        --     --     disable = not C["lsp"].enable
        --     -- },
        -- }
        --
        -- -- which key
        -- use {
        --     "folke/which-key.nvim",
        --     disable = not C["whichkey"].enable
        -- }
        --

        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end

    packer_init()


    -- Use a protected call so we don't error out on first use
    local status_ok, packer = pcall(require, "packer")
    if not status_ok then
        return
    end

    -- Have packer use a popup window
    packer.init(conf)
    packer.startup(plugins)
end

return M
