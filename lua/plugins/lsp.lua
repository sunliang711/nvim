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
    'bashls', 'solc',
    'emmet_ls'
}

-- auto format
-- nvim 0.8 works
if vim.fn.has('nvim-0.8') == 1 then
    vim.cmd [[
      autocmd BufWritePre *.html,*.css lua vim.lsp.buf.format { async = true }
      autocmd BufWritePre *.yaml,*.yml,*.json lua vim.lsp.buf.format { async = true }
      autocmd BufWritePre *.c,*.cpp lua vim.lsp.buf.format { async = true }
      autocmd BufWritePre *.rs,*.go lua vim.lsp.buf.format { async = true }
      autocmd BufWritePre *.ts,*.js lua vim.lsp.buf.format { async = true }
      autocmd BufWritePre *.py,*.sh lua vim.lsp.buf.format { async = true }
      autocmd BufWritePre *.lua lua vim.lsp.buf.format { async = true }
    ]]
else
    -- nvim 0.7 works
    vim.cmd [[
      autocmd BufWritePre *.html,*.css lua vim.lsp.buf.formatting_sync()
      autocmd BufWritePre *.yaml,*.yml,*.json lua vim.lsp.buf.formatting_sync()
      autocmd BufWritePre *.c,*.cpp lua vim.lsp.buf.formatting_sync()
      autocmd BufWritePre *.rs,*.go lua vim.lsp.buf.formatting_sync()
      autocmd BufWritePre *.ts,*.js lua vim.lsp.buf.formatting_sync()
      autocmd BufWritePre *.py,*.sh lua vim.lsp.buf.formatting_sync()
      autocmd BufWritePre *.lua lua vim.lsp.buf.formatting_sync()
    ]]
end


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
    remove_augroup "format_on_save"
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

local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
    return
end

local icons = require "icons"

local cfg = {
    debug = false, -- set to true to enable debug logging
    log_path = "debug_log_file_path", -- debug log path
    verbose = false, -- show debug line number

    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 0, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode

    floating_window_above_cur_line = false, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = icons.misc.Squirrel .. " ", -- Panda for parameter
    hint_scheme = "Comment",
    use_lspsaga = false, -- set to true if you want to use lspsaga popup
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    max_height = 12, -- max height of signature floating_window, if content is more than max_height, you can scroll down
    -- to view the hiding contents
    max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
    handler_opts = {
        border = "rounded", -- double, rounded, single, shadow, none
    },

    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58

    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom

    padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc

    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = "Black", -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
}

-- recommanded:
signature.setup(cfg) -- no need to specify bufnr if you don't use toggle_key
