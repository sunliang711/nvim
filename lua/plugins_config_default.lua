local M = {}

M.debug = false

M.impatient = {
    enable = true,
    config_module_path = "plugins.impatient",
    packer_use = {
        "lewis6991/impatient.nvim",
    }
}

M.notify = {
    enable = true,
    config_module_path = "plugins.notify",
    packer_use = {
        "rcarriga/nvim-notify",
    }
}

M.cmp = {
    enable = true,
    config_module_path = "plugins.cmp",
    packer_use = {
        {
            "hrsh7th/nvim-cmp",
        },
        {
            "hrsh7th/cmp-buffer",
        },
        {
            "hrsh7th/cmp-path",
        },
        {
            "hrsh7th/cmp-cmdline",
        },
        {
            "hrsh7th/cmp-nvim-lua",
        },
        {
            'saadparwaiz1/cmp_luasnip',
        },
        {
            "L3MON4D3/LuaSnip", --snippet engine
        },
        {
            "rafamadriz/friendly-snippets",
        },
    }
}

M.alpha = {
    enable = true,
    config_module_path = "plugins.alpha",
    packer_use = {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
    }
}

M.surround = {
    enable = true,
    config_module_path = "plugins.surround",
    packer_use = {
        {
            "tpope/vim-surround",
        },
        {
            "tpope/vim-repeat",
        }
    }
}

M.nvimtree = {
    enable = true,
    config_module_path = "plugins.nvimtree",
    packer_use = {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
    }
}

M.neoscroll = {
    enable = true,
    config_module_path = "plugins.neoscroll",
    packer_use = {
        "karb94/neoscroll.nvim",
    }
}

M.colorscheme = {
    enable = true,
    config_module_path = "plugins.colorscheme",
    packer_use = {
        { "lunarvim/darkplus.nvim" },
        { "ellisonleao/gruvbox.nvim", requires = { "rktjmp/lush.nvim" } },
        { "sainnhe/everforest" }
    }
}

M.bufferline = {
    enable = true,
    config_module_path = "plugins.bufferline",
    packer_use = {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
    }
}

M.lualine = {
    enable = true,
    config_module_path = "plugins.lualine",
    packer_use = {
        'nvim-lualine/lualine.nvim',
        requires = {
            { 'kyazdani42/nvim-web-devicons', opt = true },
            -- { 'SmiteshP/nvim-navic' },
        },
    }
}

M.gitsigns = {
    enable = true,
    config_module_path = "plugins.gitsigns",
    packer_use = {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release
    }
}

M.toggleterm = {
    enable = true,
    config_module_path = "plugins.toggleterm",
    packer_use = {
        "akinsho/toggleterm.nvim",
    }
}

M.comment = {
    enable = true,
    config_module_path = "plugins.comment",
    packer_use = {
        "numToStr/Comment.nvim",
    }
}

M.whichkey = {
    enable = true,
    config_module_path = "plugins.whichkey",
    packer_use = {
        "folke/which-key.nvim",
    }
}

M.hop = {
    enable = true,
    config_module_path = "plugins.hop",
    packer_use = {
        'phaazon/hop.nvim',
        branch = 'v1', -- optional but strongly recommended
    }
}

M.telescope = {
    enable = true,
    config_module_path = "plugins.telescope",
    packer_use = {
        'nvim-telescope/telescope.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
    }
}

M.autopairs = {
    enable = true,
    config_module_path = "plugins.autopairs",
    packer_use = {
        'windwp/nvim-autopairs',
    }
}

M.treesitter = {
    enable = true,
    config_module_path = "plugins.treesitter",
    packer_use = {
        {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
        },
        {
            "RRethy/nvim-treesitter-endwise",
        },
        {
            "windwp/nvim-ts-autotag",
        }
    }
}

M.lsp = {
    enable = true,
    config_module_path = "plugins.lsp",
    packer_use = {
        {
            "williamboman/mason.nvim",
        },
        {
            "williamboman/mason-lspconfig.nvim",
        },
        -- {
        --     "williamboman/nvim-lsp-installer",
        -- },
        {
            "neovim/nvim-lspconfig",
            -- after = "nvim-lsp-installer",
        },
        {
            "hrsh7th/cmp-nvim-lsp", -- lsp source for nvim-cmp
        },
        {
            "ray-x/lsp_signature.nvim",
        },
        {
            "RRethy/vim-illuminate",
        },
        {
            "SmiteshP/nvim-navic",
            requires = {
                { "neovim/nvim-lspconfig" }
            },
        },
        {
            "glepnir/lspsaga.nvim",
            branch = "main",
        },
        {
            "simrat39/rust-tools.nvim",
        },
        {
            "rust-lang/rust.vim",
        }
    }
}

return M
