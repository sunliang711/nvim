local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
    return
end

lsp_installer.setup({
    automatic_installation = true,
}
)

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
    return
end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = {
    'clangd', 'rust_analyzer',
    'pyright', 'tsserver',
    'gopls', 'sumneko_lua',
    'html', 'cssls',
    'yamlls', 'jsonls',
    'bashls', 'solc'
}

-- auto format
vim.cmd [[
  autocmd BufWritePre *.html,*.css lua vim.lsp.buf.format { async = true }
  autocmd BufWritePre *.yaml,*.yml,*.json lua vim.lsp.buf.format { async = true }
  autocmd BufWritePre *.c,*.cpp lua vim.lsp.buf.format { async = true }
  autocmd BufWritePre *.rs,*.go lua vim.lsp.buf.format { async = true }
  autocmd BufWritePre *.ts,*.js lua vim.lsp.buf.format { async = true }
  autocmd BufWritePre *.py,*.lua,*.sh lua vim.lsp.buf.format { async = true }
]]

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format { async = true} <CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting( { async = true} )<CR>", opts)

    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting( { async = true } )' ]]
    vim.cmd [[ command! Rename execute 'lua vim.lsp.buf.rename()' ]]
    vim.cmd [[ command! Definition execute 'lua vim.lsp.buf.definition()' ]]
    vim.cmd [[ command! Declaration execute 'lua vim.lsp.buf.declaration()' ]]
    vim.cmd [[ command! Implementation execute 'lua vim.lsp.buf.implementation()' ]]
    vim.cmd [[ command! Reference execute 'lua vim.lsp.buf.references()' ]]

end

local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    lsp_keymaps(bufnr)
end

function enable_format_on_save()
    vim.cmd [[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.formatting()
    augroup end
  ]]
    vim.notify "Enabled format on save"
end

function disable_format_on_save()
    M.remove_augroup "format_on_save"
    vim.notify "Disabled format on save"
end

function toggle_format_on_save()
    if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
        enable_format_on_save()
    else
        disable_format_on_save()
    end
end

function remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        -- on_attach = my_custom_on_attach,
        capabilities = capabilities,
        on_attach = on_attach,
    }
end
