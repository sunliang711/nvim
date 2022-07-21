local fn = vim.fn
local C  = require "plugins.pluginloader"

-- print(vim.inspect(C))

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself

    -- speed up loading lua modules in neovim
    use {
        "lewis6991/impatient.nvim",
        disable = not C["impatient"]
    }

    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        disable = not C["alpha"]
    }

    use {
        "Mephistophiles/surround.nvim",
        disable = not C["surround"]
    }
    -- use {
    --   "ur4ltz/surround.nvim",
    --   disable = not C["surround"]
    -- }

    -- nvim tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        disable = not C["nvimtree"]
    }

    -- use "lukas-reineke/indent-blankline.nvim"

    -- telescope
    use {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        disable = not C["telescope"]
    }

    -- comment
    use {
        "numToStr/Comment.nvim",
        disable = not C["comment"]
    }

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        disable = not C["gitsigns"]
        -- tag = 'release' -- To use the latest release
    }

    use {
        'windwp/nvim-autopairs',
        disable = not C["autopairs"]
    }

    -- terminal
    use {
        "akinsho/toggleterm.nvim",
        disable = not C["toggleterm"]
    }

    -- colorscheme
    use "lunarvim/darkplus.nvim"
    use { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } }

    -- bufferline
    use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        disable = not C["bufferline"]

    }
    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        disable = not C["lualine"]
    }

    use {
        "rcarriga/nvim-notify",
        disable = not C["notify"]

    }

    -- neoscroll
    use {
        "karb94/neoscroll.nvim",
        disable = not C["neoscroll"]
    }

    use {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
    }

    -- -- treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        disable = not C["treesitter"]
    }

    -- cmp (completion)
    use {
        "hrsh7th/nvim-cmp",
        disable = not C["cmp"]
    }
    use {
        "hrsh7th/cmp-buffer",
        disable = not C["cmp"]
    }
    use {
        "hrsh7th/cmp-path",
        disable = not C["cmp"]
    }
    use {
        "hrsh7th/cmp-cmdline",
        disable = not C["cmp"]
    }
    use {
        "hrsh7th/cmp-nvim-lua",
        disable = not C["cmp"]
    }

    use {
        "rust-lang/rust.vim",
        disable = not C["lsp"]
    }

    -- lsp
    use {
        {
            "williamboman/nvim-lsp-installer",
            disable = not C["lsp"]
        },
        {
            "neovim/nvim-lspconfig",
            after = "nvim-lsp-installer",
            disable = not C["lsp"]
        },
        {
            "hrsh7th/cmp-nvim-lsp", -- lsp source for nvim-cmp
        }
    }

    -- which key
    use {
        "folke/which-key.nvim",
        disable = not C["whichkey"]
    }
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
