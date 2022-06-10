vim.api.nvim_create_autocmd( { "BufReadPost" }, {
    callback = function()
        vim.cmd [[
                 if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
        ]]
    end,
})

-- augroup LastPosition
--     au!
--     autocmd BufReadPost *
--                 \ if line("'\"") > 1 && line("'\"") <= line("$")|
--                 \ execute "normal! g`\""|
--                 \ endif
-- 
