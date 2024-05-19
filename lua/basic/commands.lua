local M = {}

function M.setup()
    -- format json
    vim.cmd([[
command! JsonFormat :%!python3 -m json.tool
]])

    -- save as root
    vim.cmd([[
command! W :execute ':silent w !sudo tee % >/dev/null' | :edit!
command! Wq :execute ':silent w !sudo tee % >/dev/null' | :edit! | :quit
]])

    -- push (need share installed)
    vim.cmd([[
command! -range=% Push <line1>,<line2>!share push
command! -nargs=1 Pull :r !share pull <args>
]])

    -- 清除文件内容以外的字符，方便复制(按住option用鼠标选择)
    vim.cmd([[
    command! Pure :set nonumber | :set norelativenumber | :set nolist | :IBLDisable
    ]])

    vim.cmd([[
    command! Unpure :set number | :set relativenumber | :set list | :IBLEnable
    ]])
end

return M
