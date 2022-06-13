local M = {}

-- Not work
-- if vim.env.DEBUG_NVIM == 1 then
--     M.debug = true
-- else
--     M.debug = false
-- end

M.debug = false

-- NOTE: the following key is the same name with lua module file, eg plugins.impatient.lua, plugins.notify.lua
--
M["impatient"] = true
M["notify"] = true
M["treesitter"] = true
M["cmp"] = true
M["alpha"] = true
M["surround"] = true
M["nvimtree"] = true
M["neoscroll"] = true
M["colorscheme"] = true
M["bufferline"] = true
M["lualine"] = true
M["gitsigns"] = true
M["toggleterm"] = true
M["comment"] = true
M["whichkey"] = true
M["telescope"] = true

return M
