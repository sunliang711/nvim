local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
    return
end
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

M.setup = function()
    M.enable_format_on_save()
    local icons = require "icons"
    local signs = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn", text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint", text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo", text = icons.diagnostics.Information },
    }

    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    local config = {
        -- inlay virtual text
        virtual_text = true,
        -- show signs
        signs = {
            active = signs,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = true,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
            -- width = 40,
        },
    }

    vim.diagnostic.config(config)

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
        width = 60,
        -- height = 30,
    })

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        border = "rounded",
        width = 60,
        -- height = 30,
    })
end

local function lsp_highlight_document(client)
    -- if client.server_capabilities.document_highlight then
    local status_ok, illuminate = pcall(require, "illuminate")
    if not status_ok then
        return
    end
    illuminate.on_attach(client)
    -- end
end

local function attach_navic(client, bufnr)
    vim.g.navic_silence = true
    local status_ok, navic = pcall(require, "nvim-navic")
    if not status_ok then
        return
    end
    navic.attach(client, bufnr)
end

local saga_status, _ = pcall(require, 'lspsaga')

local function lsp_keymaps(bufnr)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    if saga_status then
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
        -- show hover doc and press twice will jumpto hover window
        vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
        -- or use command
        -- vim.keymap.set("n", "K", require("lspsaga.hover").render_hover_doc, { silent = true })


        -- local action = require("lspsaga.codeaction")
        -- code action
        -- vim.keymap.set("n", "<leader>ca", action.code_action, { silent = true, noremap = true })

        -- vim.keymap.set("v", "<leader>ca", function()
        --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-U>", true, false, true))
        --     action.range_code_action()
        -- end, { silent = true, noremap = true })
        -- or use command
        vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
        vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true, noremap = true })
    else
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
        vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format { async = true} <CR>", opts)
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
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

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
    attach_navic(client, bufnr)

    -- for tsserver
    -- if client.name == "tsserver" then
    --     require("lsp-inlayhints").setup_autocmd(bufnr, "typescript/inlayHints")
    -- end
    --
    -- -- if client.name ~= "rust_analyzer" then
    -- if client.name == "pyright" then
    --     if client.server_capabilities.inlayHintProvider then
    --         require("lsp-inlayhints").setup_autocmd(bufnr)
    --     end
    -- end

    -- if client.name == "jdt.ls" then
    --     -- TODO: instantiate capabilities in java file later
    --     M.capabilities.textDocument.completion.completionItem.snippetSupport = false
    --     vim.lsp.codelens.refresh()
    --     if JAVA_DAP_ACTIVE then
    --         require("jdtls").setup_dap { hotcodereplace = "auto" }
    --         require("jdtls.dap").setup_dap_main_class_configs()
    --     end
    -- end
end

-- if vim.fn.has('nvim-0.8') == 1 then
--     vim.cmd [[
--         augroup format_on_save
--           autocmd!
--           autocmd BufWritePre * lua vim.lsp.buf.format { async = true }
--         augroup end
--   ]]
-- else
--     vim.cmd [[
--         augroup format_on_save
--           autocmd!
--           autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()
--         augroup end
--   ]]
-- end
function M.enable_format_on_save()
    vim.cmd [[
    augroup format_on_save
      autocmd! 
      autocmd BufWritePre * lua vim.lsp.buf.format()
    augroup end
  ]]
    vim.notify "Enable format on save"
end

function M.disable_format_on_save()
    M.remove_augroup "format_on_save"
    vim.notify "Disabled format on save"
end

function M.toggle_format_on_save()
    if vim.fn.exists "#format_on_save#BufWritePre" == 0 then
        M.enable_format_on_save()
    else
        M.disable_format_on_save()
    end
end

function M.remove_augroup(name)
    if vim.fn.exists("#" .. name) == 1 then
        vim.cmd("au! " .. name)
    end
end

vim.cmd [[ command! LspToggleAutoFormat execute 'lua require("plugin-configs.lsp.handlers").toggle_format_on_save()' ]]

return M
