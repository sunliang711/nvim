local M = {}

function M.setup()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
        return
    end

    local setup = {
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = false, -- adds help for motions
                text_objects = false, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        -- key_labels = {
        --     -- override the label used to display some keys. It doesn't effect WK in any other way.
        --     -- For example:
        --     -- ["<space>"] = "SPC",
        --     -- ["<cr>"] = "RET",
        --     -- ["<tab>"] = "TAB",
        -- },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        -- popup_mappings = {
        --     scroll_down = "<c-d>", -- binding to scroll down inside the popup
        --     scroll_up = "<c-u>", -- binding to scroll up inside the popup
        -- },
        -- window = {
        --     border = "rounded", -- none, single, double, shadow
        --     position = "bottom", -- bottom, top
        --     margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        --     padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        --     winblend = 0,
        -- },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "center", -- align columns left, center or right
        },
        -- ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        -- hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false, -- show help message on the command line when the popup is visible
        -- triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        -- triggers_blacklist = {
        --     -- list of mode / prefixes that should never be hooked by WhichKey
        --     -- this is mostly relevant for key maps that start with a native binding
        --     -- most people should not need to change this
        --     i = { "j", "k" },
        --     v = { "j", "k" },
        -- },
    }

    local mappings = {
        { "<leader>b", group = "Buffer manage" },
        { "<leader>f", group = "File" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>o", group = "Options" },
        { "<leader>p", group = "Package Manage" },
        { "<leader>q", group = "Quickfix" },
        { "<leader>t", group = "Telescope" },
        { "<leader>T", group = "Terminal" },
        { "<leader>w", group = "Window and Tab" },
        { "<leader>x", group = "Trouble" },
        { "<leader>ps", "<cmd>Lazy sync<cr>", desc = "sync plugins" },
        { "<leader>pl", "<cmd>Lazy log<cr>", desc = "lazy log" },
        { "<leader>pp", "<cmd>Lazy show<cr>", desc = "lazy show" },
        { "<leader>pb", "<cmd>Lazy build<cr>", desc = "lazy build" },
        { "<leader>ow", '<cmd>lua require("functions").toggle_option("wrap")<cr>', desc = "Wrap" },
        { "<leader>or", '<cmd>lua require("functions").toggle_option("relativenumber")<cr>', desc = "Relative" },
        { "<leader>ol", '<cmd>lua require("functions").toggle_option("cursorline")<cr>', desc = "Cursorline" },
        { "<leader>oc", '<cmd>lua require("functions").toggle_option("cursorcolumn")<cr>', desc = "Cursorcolumn" },
        { "<leader>os", '<cmd>lua require("functions").toggle_option("spell")<cr>', desc = "Spell" },
        { "<leader>oD", "<cmd>set background=dark<cr>", desc = "set background to dark" },
        { "<leader>oL", "<cmd>set background=light<cr>", desc = "set background to light" },
        { "<leader>oC", "<cmd>checkhealth<cr>", desc = "Check Health" },
        { "<leader>oe", "<cmd>edit ~/.config/nvim/init.lua<cr>", desc = "edit init.lua" },
        { "<leader>op", '<cmd>lua require("functions").open_plugin_config()<cr>', desc = "edit config.lua" },
        { "<leader>h", "<cmd>set hlsearch!<cr>", desc = "No Highlight" },
        { "<leader>fw", "<cmd>wall<cr>", desc = "save all" },
        { "<leader>fq", "<cmd>wqall<cr>", desc = "save all and quit" },
        { "<leader>fQ", "<cmd>qall!<cr>", desc = "quit without save!!" },
        { "<leader>wh", "<c-w>h", desc = "left window" },
        { "<leader>wj", "<c-w>j", desc = "bottom window" },
        { "<leader>wk", "<c-w>k", desc = "top window" },
        { "<leader>wl", "<c-w>l", desc = "right window" },
        { "<leader>w[", "<cmd>bprevious<cr>", desc = "left tab" },
        { "<leader>w]", "<cmd>bnext<cr>", desc = "right tab" },
        { "<leader>w-", "<cmd>split<cr>", desc = "HSplit" },
        { "<leader>w|", "<cmd>vsplit<cr>", desc = "VSplit" },
        { "<leader>wq", "<cmd>q<cr>", desc = "Close Window" },
        { "<leader>wf", "<cmd>NvimTreeFindFile<cr>", desc = "focus file in nvim tree" },
        { "<leader>qn", "<cmd>cnext<cr>", desc = "next quickfix location" },
        { "<leader>qp", "<cmd>cprevious<cr>", desc = "previous quickfix location" },
        { "<leader>qc", "<cmd>cclose<cr>", desc = "close quickfix window" },
        { "<leader>qj", "<cmd>cnext<cr>", desc = "next quickfix location" },
        { "<leader>qk", "<cmd>cprevious<cr>", desc = "previous quickfix location" },
        { "<leader>qq", "<cmd>cclose<cr>", desc = "close quickfix window" },
    }

    which_key.setup(setup)
    which_key.add(mappings)
end

return M
