local fn = vim.fn
local C  = require "pluginloader"

-- C["impatient"] = true
-- C["notify"] = true
-- C["treesitter"] = true
-- C["cmp"] = true
-- C["alpha"] = true
-- C["surround"] = true
-- C["nvimtree"] = true
-- C["neoscroll"] = true
-- C["colorscheme"] = true
-- C["bufferline"] = true
-- C["lualine"] = true
-- C["gitsigns"] = true
-- C["toggleterm"] = true
-- C["comment"] = true
-- C["whichkey"] = true
-- C["telescope"] = true
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
    cond = C["impatient"]
  }

  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    cond = C["alpha"]
  }

  use {
    "Mephistophiles/surround.nvim",
    cond = C["surround"]
  }

  -- nvim tree
    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons',
        cond = C["nvimtree"]
    }

  -- use "lukas-reineke/indent-blankline.nvim"

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    cond = C["telescope"]
  }

  -- comment
  use {
    "numToStr/Comment.nvim",
    cond = C["comment"]
  }

  -- git
  use {
    'lewis6991/gitsigns.nvim',
    cond = C["gitsigns"]
    -- tag = 'release' -- To use the latest release
  }
 
  -- terminal
  use {
    "akinsho/toggleterm.nvim",
    cond = C["toggleterm"]
  }

  -- colorscheme
  use "lunarvim/darkplus.nvim"
  use {"ellisonleao/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}

  -- bufferline
  use {
        'akinsho/bufferline.nvim',
        tag = "v2.*",
        requires = 'kyazdani42/nvim-web-devicons',
        cond = C["bufferline"]

  }
  -- lualine
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    cond = C["lualine"]
  }
 
  use {
    "rcarriga/nvim-notify",
    cond = C["notify"]

  }
 
  -- neoscroll
  use {
    "karb94/neoscroll.nvim",
    cond = C["neoscroll"]
  }

  -- -- treesitter
    use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    cond = C["treesitter"]
  }

  -- cmp (completion)
  use {
    "hrsh7th/nvim-cmp",
    cond = C["cmp"]
  }
  use {
    "hrsh7th/cmp-buffer",
    cond = C["cmp"]
  }
  use {
    "hrsh7th/cmp-path",
    cond = C["cmp"]
  }
  use {
    "hrsh7th/cmp-cmdline",
    cond = C["cmp"]
  }
  use {
    "hrsh7th/cmp-nvim-lua",
    cond = C["cmp"]
  }

  -- which key
  use {
    "folke/which-key.nvim",
    cond = C["whichkey"]
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

