local M = {}

function M.setup()
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        callback = function()
            vim.cmd([[
                 if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
        ]])
        end,
    })

    vim.cmd([[
        -- 复制时高亮
        augroup YankHighlight
            autocmd!
            autocmd TextYankPost * silent! lua vim.highlight.on_yank()
        augroup end
    ]])

    vim.cmd([[
        -- go语言设置
        augroup golang
            autocmd!
            -- set list 和 indent-blankline插件冲突，这里取消掉
            autocmd FileType go set nolist
        augroup end
    ]])
end

return M
