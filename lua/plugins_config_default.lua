local M = {}

M.debug = false

M.impatient   = { enable = true, module_path = "plugins.impatient" }
M.notify      = { enable = true, module_path = "plugins.notify" }
M.cmp         = { enable = true, module_path = "plugins.cmp" }
M.alpha       = { enable = true, module_path = "plugins.alpha" }
M.surround    = { enable = true, module_path = "plugins.surround" }
M.nvimtree    = { enable = true, module_path = "plugins.nvimtree" }
M.neoscroll   = { enable = true, module_path = "plugins.neoscroll" }
M.colorscheme = { enable = true, module_path = "plugins.colorscheme" }
M.bufferline  = { enable = true, module_path = "plugins.bufferline" }
M.lualine     = { enable = true, module_path = "plugins.lualine" }
M.gitsigns    = { enable = true, module_path = "plugins.gitsigns" }
M.toggleterm  = { enable = true, module_path = "plugins.toggleterm" }
M.comment     = { enable = true, module_path = "plugins.comment" }
M.whichkey    = { enable = true, module_path = "plugins.whichkey" }
M.hop         = { enable = true, module_path = "plugins.hop" }
M.telescope   = { enable = true, module_path = "plugins.telescope" }
M.autopairs   = { enable = true, module_path = "plugins.autopairs" }

M.treesitter = { enable = false, module_path = "plugins.treesitter" }
M.lsp        = { enable = false, module_path = "plugins.lsp" }

return M
