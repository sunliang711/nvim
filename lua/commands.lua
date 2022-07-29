local M = {}

function M.setup()
    -- format json
    vim.cmd [[
command! JsonFormat :%!python3 -m json.tool
]]

    -- save as root
    vim.cmd [[
command! W :execute ':silent w !sudo tee % >/dev/null' | :edit!
command! Wq :execute ':silent w !sudo tee % >/dev/null' | :edit! | :quit
]]

end

return M
