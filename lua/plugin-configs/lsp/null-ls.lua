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

    local b = null_ls.builtins
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    -- local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    -- local diagnostics = null_ls.builtins.diagnostics

    local with_diagnostics_code = function(builtin)
        return builtin.with {
            diagnostics_format = "#{m} [#{c}]",
        }
    end

    local with_root_file = function(builtin, file)
        return builtin.with {
            condition = function(utils)
                return utils.root_has_file(file)
            end,
        }
    end

    null_ls.setup({
        debug = false,
        sources = {
            -- formatting
            -- npm install -g @fsouza/prettierd
            b.formatting.prettierd,
            -- go install mvdan.cc/sh/v3/cmd/shfmt@latest
            b.formatting.shfmt,
            -- npm install -g fixjson
            b.formatting.fixjson,
            -- pip install black
            b.formatting.black.with { extra_args = { "--fast" } },
            -- pip install isort
            b.formatting.isort,
            with_root_file(b.formatting.stylua, "stylua.toml"),
            -- cargo install stylua
            b.formatting.stylua,

            -- diagnostics.flake8
            -- diagnostics
            b.diagnostics.write_good,
            -- b.diagnostics.markdownlint,
            -- b.diagnostics.eslint_d,
            b.diagnostics.flake8,
            b.diagnostics.tsc,
            with_root_file(b.diagnostics.selene, "selene.toml"),
            with_diagnostics_code(b.diagnostics.shellcheck),

            -- code actions
            b.code_actions.gitsigns,
            b.code_actions.gitrebase,

            -- hover
            b.hover.dictionary,
        },
        on_attach = require("plugin-configs.lsp.handlers").on_attach
    })
end

return M
