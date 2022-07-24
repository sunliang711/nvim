local M = {}

function M.setup()
    local status_ok, nls = pcall(require, 'null-ls')
    if not status_ok then
        return
    end
    local b = nls.builtins

    nls.setup({
        sources = {
            b.formatting.prettier.with({
                filetypes = { "python" }
            }),
            b.formatting.stylua,
            b.formatting.shfmt,

            b.diagnostics.eslint,

            b.completion.spell,
        }
    })
end

return M
