local M = {}

function M.setup()
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
        return
    end

    local lsp_loaded = true
    local status_ok, lspconfig = pcall(require, "lspconfig")
    if not status_ok then
        lsp_loaded = false
    end

    -- local cmp_dap_status_ok, cmp_dap = pcall(require, "cmp_dap")
    -- if not cmp_dap_status_ok then
    --   return
    -- end

    local snip_status_ok, luasnip = pcall(require, "luasnip")
    if not snip_status_ok then
        return
    end

    vim.api.nvim_create_autocmd({ "CursorHold" }, {
        callback = function()
            local luasnip = require("luasnip")
            if luasnip.expand_or_jumpable() then
                -- ask maintainer for option to make this silent
                -- luasnip.unlink_current()
                vim.cmd([[silent! lua require("luasnip").unlink_current()]])
            end
        end,
    })

    require("luasnip/loaders/from_vscode").lazy_load()

    local check_backspace = function()
        local col = vim.fn.col(".") - 1
        return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    local icons = require("icons")

    local kind_icons = icons.kind

    local sources = {
        { name = "buffer", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "nvim_lua", group_index = 2 },
        { name = "luasnip", group_index = 2 },
        { name = "emoji", group_index = 2 },
        -- { name = 'nvim_lsp_signature_help' },
        -- { name = "nvim_lsp" },
        -- { name = "cmp_tabnine" },
        -- { name = "emoji" },
        -- { name = "dap" },
    }
    if lsp_loaded then
        table.insert(sources, { name = "nvim_lsp", group_index = 1 })
    end

    if PLUGINS.copilot.enabled then
        table.insert(sources, { name = "copilot", group_index = 1 })
    end

    local kind_icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
    }

    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body) -- For `luasnip` users.
            end,
        },

        enabled = function()
            -- return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or cmp_dap.is_dap_buffer()
            return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" -- or cmp_dap.is_dap_buffer()
        end,

        mapping = cmp.mapping.preset.insert({
            -- ["<C-k>"] = cmp.mapping.select_prev_item(),
            -- ["<C-j>"] = cmp.mapping.select_next_item(),
            ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c", "s" }),
            ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c", "s" }),
            ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
            ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
            -- not works?
            ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
            -- ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
            -- Accept currently selected item. If none selected, `select` first item.
            -- Set `select` to `false` to only confirm explicitly selected items.
            ["<CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                -- behavior = cmp.ConfirmBehavior.Insert,
                select = false,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expandable() then
                    luasnip.expand()
                elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                elseif check_backspace() then
                    fallback()
                else
                    fallback()
                end
            end, {
                "i",
                "s",
                "c",
            }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, {
                "i",
                "s",
                "c",
            }),
        }),
        formatting = {
            format = function(entry, vim_item)
                -- Kind icons
                vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
                -- Source
                vim_item.menu = ({
                    copilot = "[Copilot]",
                    buffer = "[Buffer]",
                    nvim_lsp = "[LSP]",
                    luasnip = "[LuaSnip]",
                    nvim_lua = "[Lua]",
                    latex_symbols = "[LaTeX]",
                })[entry.source.name]
                return vim_item
            end,
        },
        -- formatting = {
        --     fields = { "kind", "abbr", "menu" },
        --     format = function(entry, vim_item)
        --         -- Kind icons
        --         vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        --
        --         if entry.source.name == "cmp_tabnine" then
        --             -- if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
        --             -- menu = entry.completion_item.data.detail .. " " .. menu
        --             -- end
        --             vim_item.kind = icons.misc.Robot
        --         end
        --         -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        --         -- NOTE: order matters
        --         vim_item.menu = ({
        --             copilot = "[Copilot]",
        --             nvim_lsp = "[NVIM LSP]",
        --             nvim_lua = "[Nvim lua]",
        --             luasnip = "[Snippet]",
        --             buffer = "[Buffer]",
        --             path = "[Path]",
        --             emoji = "[Emoji]",
        --         })[entry.source.name]
        --         return vim_item
        --     end,
        -- },
        sources = sources,
        -- confirm_opts = {
        --   -- behavior = cmp.ConfirmBehavior.Replace,
        --   behavior = cmp.ConfirmBehavior.Insert,
        --   select = true,
        -- },
        -- documentation = true,
        window = {
            -- documentation = "native",
            documentation = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
            },
            completion = {
                border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
                winhighlight = "NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None",
            },
        },
        experimental = {
            ghost_text = true,
            -- native_menu = false,
        },
    })

    -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
        }, {
            { name = "cmdline" },
        }),
    })
end

return M
