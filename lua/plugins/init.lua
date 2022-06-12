local fn = vim.fn
local C = require "pluginloader"

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
    cond = function() return C["impatient"] end
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    cond = function() return C["alpha"] end
  }

  use {
    "Mephistophiles/surround.nvim",
    cond = function() return C["surround"] end
  }

  -- nvim tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        cond = function() return C["nvimtree"] end
    }

  -- use "lukas-reineke/indent-blankline.nvim"

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    cond = function() return C["telescope"] end
  }

  -- comment
  use {
    "numToStr/Comment.nvim",
    cond = function() return C["comment"] end
  }

  -- git
  use {
    'lewis6991/gitsigns.nvim',
    cond = function() return C["gitsigns"] end
    -- tag = 'release' -- To use the latest release
  }
 
  -- terminal
  use {
    "akinsho/toggleterm.nvim",
    cond = function() return C["toggleterm"] end
  }

  -- colorscheme
  use "lunarvim/darkplus.nvim"
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- bufferline
  use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        cond = function() return C["bufferline"] end

  }
  -- lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    cond = function() return C["lualine"] end
  }
 
  use {
    "rcarriga/nvim-notify",
    cond = function() return C["notify"] end

  }
 
  -- neoscroll
  use {
    "karb94/neoscroll.nvim",
    cond = function() return C["neoscroll"] end
  }

  -- -- treesitter
    use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    cond = function() return C["treesitter"] end
  }

  -- cmp (completion)
  use {
    "hrsh7th/nvim-cmp",
    cond =function() return C["cmp"] end
  }
  use {
    "hrsh7th/cmp-buffer",
    cond =function() return C["cmp"] end
  }
  use {
    "hrsh7th/cmp-path",
    cond =function() return C["cmp"] end
  }
  use {
    "hrsh7th/cmp-cmdline",
    cond =function() return C["cmp"] end
  }
  use {
    "hrsh7th/cmp-nvim-lua",
    cond =function() return C["cmp"] end
  }

  -- which key
  use {
    "folke/which-key.nvim",
    cond =function() return C["whichkey"] end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

