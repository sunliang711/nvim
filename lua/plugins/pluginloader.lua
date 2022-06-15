local M = {}
local env = vim.fn.environ()

if( env['debug_nvim'] == '1' ) then
    M.debug = true
else
    M.debug = false
end

-- treesitter is a HEAVY plugin, so enable it by environment variable (enable_treesitter),default is disable
if( env['enable_treesitter'] == '1' ) then
    M["treesitter"] = true
else
    M["treesitter"] = false
end

-- NOTE: the following key is the same name with lua module file, eg plugins.impatient.lua, plugins.notify.lua
--
M["impatient"] = true
M["notify"] = true
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
