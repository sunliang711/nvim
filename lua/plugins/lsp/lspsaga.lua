local M = {}

function M.setup()
    local saga_status, saga = pcall(require, 'lspsaga')
    if not saga_status then
        return
    end

    local opts = { noremap = true, silent = true }

    -- lsp finder to find the cursor word definition and reference

    if vim.fn.has('nvim-0.8') == 1 then
        vim.keymap.set("n", "gh", require("lspsaga.finder").lsp_finder, { silent = true, noremap = true })
    end
    -- or use command LspSagaFinder
    -- vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })

    vim.keymap.set("n", "<leader>to", "<cmd>LSoutlineToggle<CR>", opts)
    vim.keymap.set("n", "<leader>pd", "<cmd>Lspsaga preview_definition<CR>", opts)

    local action_status, action = pcall(require, "lspsaga.action")
    if action_status then
        -- scroll down hover doc or scroll in definition preview
        vim.keymap.set("n", "<C-f>", function() action.smart_scroll_with_saga(1) end, { silent = true })
        -- scroll up hover doc
        vim.keymap.set("n", "<C-b>", function() action.smart_scroll_with_saga(-1) end, { silent = true })
    end



    saga.init_lsp_saga {
        -- "single" | "double" | "rounded" | "bold" | "plus"
        border_style = "bold",
        --the range of 0 for fully opaque window (disabled) to 100 for fully
        --transparent background. Values between 0-30 are typically most useful.
        saga_winblend = 0,
        -- when cursor in saga window you config these to move
        move_in_saga = { prev = '<C-p>', next = '<C-n>' },
        -- Error, Warn, Info, Hint
        -- use emoji like
        -- { "🙀", "😿", "😾", "😺" }
        -- or
        -- { "😡", "😥", "😤", "😐" }
        -- and diagnostic_header can be a function type
        -- must return a string and when diagnostic_header
        -- is function type it will have a param `entry`
        -- entry is a table type has these filed
        -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
        diagnostic_header = { " ", " ", " ", "ﴞ " },
        -- show diagnostic source
        -- show_diagnostic_source = true,
        -- add bracket or something with diagnostic source, just have 2 elements
        -- diagnostic_source_bracket = {},
        -- preview lines of lsp_finder and definition preview
        max_preview_lines = 10,
        -- use emoji lightbulb in default
        code_action_icon = "💡",
        -- if true can press number to execute the codeaction in codeaction window
        code_action_num_shortcut = true,
        -- same as nvim-lightbulb but async
        code_action_lightbulb = {
            enable = true,
            sign = true,
            enable_in_insert = true,
            sign_priority = 20,
            virtual_text = true,
        },
        -- finder icons
        finder_icons = {
            def = '  ',
            ref = '諭 ',
            link = '  ',
        },
        -- custom finder title winbar function type
        -- param is current word with symbol icon string type
        -- return a winbar format string like `%#CustomFinder#Test%*`
        -- finder_title_bar = function(param) do your stuff here end,
        finder_action_keys = {
            open = "o",
            vsplit = "s",
            split = "i",
            tabe = "t",
            quit = "q",
            scroll_down = "<C-f>",
            scroll_up = "<C-b>", -- quit can be a table
        },
        code_action_keys = {
            quit = "q",
            exec = "<CR>",
        },
        -- rename_action_quit = "<C-c>",
        rename_action_quit = "q",
        -- definition_preview_icon = "  ",
        -- show symbols in winbar must nightly
        symbol_in_winbar = {
            in_custom = false,
            enable = false,
            separator = ' ',
            show_file = true,
            click_support = false,
        },
        -- show outline
        show_outline = {
            win_position = 'right',
            -- set the special filetype in there which in left like nvimtree neotree defx
            left_with = '',
            win_width = 30,
            auto_enter = true,
            auto_preview = true,
            virt_text = '┃',
            jump_key = 'o',
            -- auto refresh when change buffer
            auto_refresh = true,
        },
        -- if you don't use nvim-lspconfig you must pass your server name and
        -- the related filetypes into this table
        -- like server_filetype_map = { metals = { "sbt", "scala" } }
        server_filetype_map = {},
    }

end

return M
