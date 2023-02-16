local M = {}

function M.setup()
    vim.api.nvim_create_autocmd({ "BufReadPost" }, {
        callback = function()
            vim.cmd [[
                 if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
        ]]
        end,
    })

    vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

end

return M
