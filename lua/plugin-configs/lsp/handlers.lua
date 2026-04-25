local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
-- M.capabilities = cmp_nvim_lsp.update_capabilities(M.capabilities)
if status_cmp_ok then
    -- cmp 不可用时回退到原生 capabilities，避免 require 失败
    M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
end

M.setup = function()
    M.enable_format_on_save(false)
    local icons = require("icons")
    local signs = {
        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warning,
        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
        [vim.diagnostic.severity.INFO] = icons.diagnostics.Information,
    }

    local config = {
        -- inlay virtual text
        virtual_text = true,
        -- show signs
        signs = {
            text = signs,
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

    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, handler_config)
        local merged = vim.tbl_deep_extend("force", handler_config or {}, {
            border = "rounded",
            width = 60,
        })
        return vim.lsp.handlers.hover(err, result, ctx, merged)
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, handler_config)
        local merged = vim.tbl_deep_extend("force", handler_config or {}, {
            border = "rounded",
            width = 60,
        })
        return vim.lsp.handlers.signature_help(err, result, ctx, merged)
    end
end

local function lsp_highlight_document(client)
    if client == nil or not client:supports_method("textDocument/documentHighlight") then
        return
    end

    local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. vim.api.nvim_get_current_buf(), { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = group,
        buffer = vim.api.nvim_get_current_buf(),
        callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "BufLeave" }, {
        group = group,
        buffer = vim.api.nvim_get_current_buf(),
        callback = vim.lsp.buf.clear_references,
    })
end

local function attach_navic(client, bufnr)
    if not PLUGINS.lsp.navic then
        return
    end
    vim.g.navic_silence = true
    local status_ok, navic = pcall(require, "nvim-navic")
    if not status_ok then
        return
    end
    navic.attach(client, bufnr)
end

local function has_lspsaga()
    if not PLUGINS.lsp.saga then
        return false
    end

    return pcall(require, "lspsaga")
end

local function lsp_keymaps(bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }
    local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
    end

    map("n", "gD", vim.lsp.buf.declaration, "LSP Declaration")
    map("n", "gd", vim.lsp.buf.definition, "LSP Definition")
    map("n", "gI", vim.lsp.buf.implementation, "LSP Implementation")
    map("n", "gy", vim.lsp.buf.type_definition, "LSP Type Definition")
    if has_lspsaga() then
        map("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", "Rename")
        -- show hover doc and press twice will jumpto hover window
        map("n", "K", "<cmd>Lspsaga hover_doc<CR>", "LSP Hover")
        map("i", "<c-k>", "<cmd>Lspsaga hover_doc<CR>", "LSP Hover")
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
        map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", "Code Action")
        map("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", "Code Action")
    else
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
        map("n", "K", vim.lsp.buf.hover, "LSP Hover")
        map("i", "<c-k>", vim.lsp.buf.hover, "LSP Hover")
        -- vim.lsp.buf.signature_help
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
    end
    map("n", "gr", vim.lsp.buf.references, "LSP References")
    map("n", "<leader>lF", function()
        vim.lsp.buf.format({ async = true })
    end, "LSP Format")
    map("n", "gl", vim.diagnostic.open_float, "Line Diagnostics")
    -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format { async = true }' ]]
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>', opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
    -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.formatting( { async = true} )<CR>", opts)

    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
    vim.cmd([[ command! Rename execute 'lua vim.lsp.buf.rename()' ]])
    vim.cmd([[ command! Definition execute 'lua vim.lsp.buf.definition()' ]])
    vim.cmd([[ command! Declaration execute 'lua vim.lsp.buf.declaration()' ]])
    vim.cmd([[ command! Implementation execute 'lua vim.lsp.buf.implementation()' ]])
    vim.cmd([[ command! Reference execute 'lua vim.lsp.buf.references()' ]])
end

M.on_attach = function(client, bufnr)
    lsp_keymaps(bufnr)
    lsp_highlight_document(client)
    attach_navic(client, bufnr)

    -- for tsserver
    -- if client.name == "tsserver" then
    -- require("lsp-inlayhints").setup_autocmd(bufnr, "typescript/inlayHints")
    -- require("lsp-inlayhints").on_attach(client, bufnr)
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
function M.enable_format_on_save(notify_user)
    vim.cmd([[
    augroup format_on_save
      autocmd!
      autocmd BufWritePre * lua vim.lsp.buf.format()
    augroup end
  ]])
    if notify_user ~= false then
        vim.notify("Enable format on save")
    end
end

function M.disable_format_on_save()
    M.remove_augroup("format_on_save")
    vim.notify("Disabled format on save")
end

function M.toggle_format_on_save()
    if vim.fn.exists("#format_on_save#BufWritePre") == 0 then
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

vim.cmd([[ command! LspToggleAutoFormat execute 'lua require("plugin-configs.lsp.handlers").toggle_format_on_save()' ]])

return M
