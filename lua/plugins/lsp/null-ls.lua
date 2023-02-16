local M = {}

function M.setup()
    -- local status_ok, nls = pcall(require, 'null-ls')
    -- if not status_ok then
    --     return
    -- end
    -- local b = nls.builtins
    --
    -- nls.setup({
    --     sources = {
    --         b.formatting.prettier.with({
    --             filetypes = { "python" }
    --         }),
    --         b.formatting.stylua,
    --         b.formatting.shfmt,
    --
    --         b.diagnostics.eslint,
    --
    --         b.completion.spell,
    --     }
    -- })


    local null_ls_status_ok, null_ls = pcall(require, "null-ls")
    if not null_ls_status_ok then
        return
    end

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
        debug = false,
        sources = {
            formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
            -- pip install black
            formatting.black.with({ extra_args = { "--fast" } }),
            formatting.stylua,
            -- diagnostics.flake8
        },
    })
end

return M
