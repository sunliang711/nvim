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
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            -- ["<space>"] = "SPC",
            -- ["<cr>"] = "RET",
            -- ["<tab>"] = "TAB",
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = "rounded", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3, -- spacing between columns
            align = "center", -- align columns left, center or right
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false, -- show help message on the command line when the popup is visible
        -- triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
        },
    }

    local opts = {
        mode = "v", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        remap = false, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local m_opts = {
        mode = "n", -- NORMAL mode
        prefix = "m",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        remap = false, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local m_mappings = {
        a = { "<cmd>BookmarkAnnotate<cr>", "Annotate" },
        c = { "<cmd>BookmarkClear<cr>", "Clear" },
        m = { "<cmd>BookmarkToggle<cr>", "Toggle" },
        h = { '<cmd>lua require("harpoon.mark").add_file()<cr>', "Harpoon" },
        j = { "<cmd>BookmarkNext<cr>", "Next" },
        k = { "<cmd>BookmarkPrev<cr>", "Prev" },
        s = { "<cmd>BookmarkShowAll<cr>", "Prev" },
        -- s = {
        --   "<cmd>lua require('telescope').extensions.vim_bookmarks.all({ hide_filename=false, prompt_title=\"bookmarks\", shorten_path=false })<cr>",
        --   "Show",
        -- },
        x = { "<cmd>BookmarkClearAll<cr>", "Clear All" },
        u = { '<cmd>lua require("harpoon.ui").toggle_quick_menu()<cr>', "Harpoon UI" },
    }

    local mappings = {
        -- [";"] = { "<cmd>Alpha<cr>", "Dashboard" },
        {
            "<leader>;",
            "<cmd>Alpha<cr>",
            desc = "Dashboard",
            nowait = true,
            remap = false,
        },
        -- ["e"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
        {
            "<leader>e",
            "<cmd>NvimTreeToggle<cr>",
            desc = "File Explorer",
            nowait = true,
            remap = false,
        },
        -- ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
        {
            "<leader>/",
            '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>',
            desc = "Comment",
            nowait = true,
            remap = false,
        },
        -- p = {
        --     name = "Package Manage",
        --     s = { "<cmd>Lazy sync<cr>", "sync plugins" },
        --     l = { "<cmd>Lazy log<cr>", "lazy log" },
        --     p = { "<cmd>Lazy show<cr>", "lazy show" },
        --     b = { "<cmd>Lazy build<cr>", "lazy build" },
        -- },
        {
            "<leader>p",
            group = "Package Manage",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ps",
            "<cmd>Lazy sync<cr>",
            desc = "sync plugins",
            nowait = true,
            remap = false,
        },
        {
            "<leader>pl",
            "<cmd>Lazy log<cr>",
            desc = "lazy log",
            nowait = true,
            remap = false,
        },
        {
            "<leader>pp",
            "<cmd>Lazy show<cr>",
            desc = "lazy show",
            nowait = true,
            remap = false,
        },
        {
            "<leader>pb",
            "<cmd>Lazy build<cr>",
            desc = "lazy build",
            nowait = true,
            remap = false,
        },
        -- o = {
        --     name = "Options",
        --     w = { '<cmd>lua require("functions").toggle_option("wrap")<cr>', "Wrap" },
        --     r = { '<cmd>lua require("functions").toggle_option("relativenumber")<cr>', "Relative" },
        --     l = { '<cmd>lua require("functions").toggle_option("cursorline")<cr>', "Cursorline" },
        --     c = { '<cmd>lua require("functions").toggle_option("cursorcolumn")<cr>', "Cursorcolumn" },
        --     s = { '<cmd>lua require("functions").toggle_option("spell")<cr>', "Spell" },
        --     D = { "<cmd>set background=dark<cr>", "set background to dark" },
        --     L = { "<cmd>set background=light<cr>", "set background to light" },
        --     C = { "<cmd>checkhealth<cr>", "Check Health" },
        --     e = { "<cmd>edit ~/.config/nvim/init.lua<cr>", "edit init.lua" },
        --     -- t = { '<cmd>lua require("functions").toggle_tabline()<cr>', "Tabline" },
        -- },
        {
            "<leader>o",
            group = "Options",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ow",
            '<cmd>lua require("functions").toggle_option("wrap")<cr>',
            desc = "Wrap",
            nowait = true,
            remap = false,
        },
        {
            "<leader>or",
            '<cmd>lua require("functions").toggle_option("relativenumber")<cr>',
            desc = "Relative",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ol",
            '<cmd>lua require("functions").toggle_option("cursorline")<cr>',
            desc = "Cursorline",
            nowait = true,
            remap = false,
        },
        {
            "<leader>oc",
            '<cmd>lua require("functions").toggle_option("cursorcolumn")<cr>',
            desc = "Cursorcolumn",
            nowait = true,
            remap = false,
        },
        {
            "<leader>os",
            '<cmd>lua require("functions").toggle_option("spell")<cr>',
            desc = "Spell",
            nowait = true,
            remap = false,
        },
        {
            "<leader>oD",
            "<cmd>set background=dark<cr>",
            desc = "set background to dark",
            nowait = true,
            remap = false,
        },
        {
            "<leader>oL",
            "<cmd>set background=light<cr>",
            desc = "set background to light",
            nowait = true,
            remap = false,
        },
        {
            "<leader>oC",
            "<cmd>checkhealth<cr>",
            desc = "Check Health",
            nowait = true,
            remap = false,
        },
        {
            "<leader>oe",
            "<cmd>edit ~/.config/nvim/init.lua<cr>",
            desc = "edit init.lua",
            nowait = true,
            remap = false,
        },
        -- h = {
        --     { "<cmd>nohlsearch<cr>", "No Highlight" },
        -- },
        {
            "<leader>h",
            group = "Highlight",
            nowait = true,
            remap = false,
        },
        {
            "<leader>h",
            "<cmd>nohlsearch<cr>",
            desc = "No Highlight",
            nowait = true,
            remap = false,
        },
        -- b = {
        --     name = "Buffer manage",
        --     h = { "<cmd>BufferLineCloseLeft<cr>", "close all to the left" },
        --     l = { "<cmd>BufferLineCloseRight<cr>", "close all to the right" },
        --     o = { "<cmd>BufferLineCloseOthers<cr>", "close all other tabs" },
        --     c = { "<cmd>BufferLinePickClose<cr>", "pick buffer to close" },
        --     d = { "<cmd>bdelete<cr>", "close current buffer" },
        --
        --     p = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
        --     n = { "<cmd>BufferLineCycleNext<cr>", "next" },
        --
        --     b = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
        --     j = { "<cmd>BufferLinePick<cr>", "jump" },
        -- },
        {
            "<leader>b",
            group = "Buffer manage",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bh",
            "<cmd>BufferLineCloseLeft<cr>",
            desc = "close all to the left",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bl",
            "<cmd>BufferLineCloseRight<cr>",
            desc = "close all to the right",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bo",
            "<cmd>BufferLineCloseOthers<cr>",
            desc = "close all other tabs",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bc",
            "<cmd>BufferLinePickClose<cr>",
            desc = "pick buffer to close",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bd",
            "<cmd>bdelete<cr>",
            desc = "close current buffer",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bp",
            "<cmd>BufferLineCyclePrev<cr>",
            desc = "previous",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bn",
            "<cmd>BufferLineCycleNext<cr>",
            desc = "next",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bb",
            "<cmd>BufferLineCyclePrev<cr>",
            desc = "previous",
            nowait = true,
            remap = false,
        },
        {
            "<leader>bj",
            "<cmd>BufferLinePick<cr>",
            desc = "jump",
            nowait = true,
            remap = false,
        },
        -- w = {
        --     name = "Window and Tab",
        --     h = { "<c-w>h", "left window" },
        --     j = { "<c-w>j", "bottom window" },
        --     k = { "<c-w>k", "top window" },
        --     l = { "<c-w>l", "right window" },
        --     ["["] = { "<cmd>bprevious<cr>", "left tab" },
        --     ["]"] = { "<cmd>bnext<cr>", "right tab" },
        --     ["-"] = { "<cmd>split<cr>", "HSplit" },
        --     ["|"] = { "<cmd>vsplit<cr>", "VSplit" },
        --     q = { "<cmd>q<cr>", "Close Window" },
        --     f = { "<cmd>NvimTreeFindFile<cr>", "focus file in nvim tree" },
        -- },
        { "<leader>w", group = "Window and Tab", nowait = true, remap = false },
        {
            "<leader>wh",
            "<c-w>h",
            desc = "left window",
            nowait = true,
            remap = false,
        },
        {
            "<leader>wj",
            "<c-w>j",
            desc = "bottom window",
            nowait = true,
            remap = false,
        },
        {
            "<leader>wk",
            "<c-w>k",
            desc = "top window",
            nowait = true,
            remap = false,
        },
        {
            "<leader>wl",
            "<c-w>l",
            desc = "right window",
            nowait = true,
            remap = false,
        },
        {
            "<leader>w[",
            "<cmd>bprevious<cr>",
            desc = "left tab",
            nowait = true,
            remap = false,
        },
        {
            "<leader>w]",
            "<cmd>bnext<cr>",
            desc = "right tab",
            nowait = true,
            remap = false,
        },
        {
            "<leader>w-",
            "<cmd>split<cr>",
            desc = "HSplit",
            nowait = true,
            remap = false,
        },
        {
            "<leader>w|",
            "<cmd>vsplit<cr>",
            desc = "VSplit",
            nowait = true,
            remap = false,
        },
        {
            "<leader>wq",
            "<cmd>q<cr>",
            desc = "Close Window",
            nowait = true,
            remap = false,
        },
        {
            "<leader>wf",
            "<cmd>NvimTreeFindFile<cr>",
            desc = "focus file in nvim tree",
            nowait = true,
            remap = false,
        },
        -- q = {
        --     name = "Quickfix",
        --     n = { "<cmd>cnext<cr>", "next quickfix location" },
        --     p = { "<cmd>cprevious<cr>", "previous quickfix location" },
        --     c = { "<cmd>cclose<cr>", "close quickfix window" },
        --
        --     j = { "<cmd>cnext<cr>", "next quickfix location" },
        --     k = { "<cmd>cprevious<cr>", "previous quickfix location" },
        --     q = { "<cmd>cclose<cr>", "close quickfix window" },
        -- },
        { "<leader>q", group = "Quickfix", nowait = true, remap = false },
        {
            "<leader>qn",
            "<cmd>cnext<cr>",
            desc = "next quickfix location",
            nowait = true,
            remap = false,
        },
        {
            "<leader>qp",
            "<cmd>cprevious<cr>",
            desc = "previous quickfix location",
            nowait = true,
            remap = false,
        },
        {
            "<leader>qc",
            "<cmd>cclose<cr>",
            desc = "close quickfix window",
            nowait = true,
            remap = false,
        },
        {
            "<leader>qj",
            "<cmd>cnext<cr>",
            desc = "next quickfix location",
            nowait = true,
            remap = false,
        },
        {
            "<leader>qk",
            "<cmd>cprevious<cr>",
            desc = "previous quickfix location",
            nowait = true,
            remap = false,
        },
        {
            "<leader>qq",
            "<cmd>cclose<cr>",
            desc = "close quickfix window",
            nowait = true,
            remap = false,
        },
        -- T = {
        --     name = "Terminal",
        --     t = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
        --     h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal Terminal" },
        --     v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical Terminal" },
        -- },
        { "<leader>T", group = "Terminal", nowait = true, remap = false },
        {
            "<leader>Tt",
            "<cmd>ToggleTerm direction=float<cr>",
            desc = "Float",
            nowait = true,
            remap = false,
        },
        {
            "<leader>Th",
            "<cmd>ToggleTerm size=10 direction=horizontal<cr>",
            desc = "Horizontal Terminal",
            nowait = true,
            remap = false,
        },
        {
            "<leader>Tv",
            "<cmd>ToggleTerm size=80 direction=vertical<cr>",
            desc = "Vertical Terminal",
            nowait = true,
            remap = false,
        },
        -- f = {
        --     name = "File",
        --
        --     F = { "<cmd>Telescope find_files<cr>", "Find Files (With Previewer)" },
        --     f = {
        --         "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        --         "Find Files",
        --     },
        --
        --     t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
        --     b = { "<cmd>Telescope buffers<cr>", "Buffer List" },
        --     r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
        --     -- i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
        --     w = { "<cmd>wall<cr>", "save all" },
        --     c = { "<cmd>Telescope commands<cr>", "Commands" },
        --
        --     q = { "<cmd>wqall<cr>", "save all and quit" },
        --     Q = { "<cmd>qall!<cr>", "quit without save!!" },
        -- },
        { "<leader>f", group = "File", nowait = true, remap = false },
        {
            "<leader>fF",
            "<cmd>Telescope find_files<cr>",
            desc = "Find Files (With Previewer)",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ff",
            '<cmd>lua require("telescope.builtin").find_files(require("telescope.themes").get_dropdown{previewer = false})<cr>',
            desc = "Find Files",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ft",
            "<cmd>Telescope live_grep theme=ivy<cr>",
            desc = "Find Text",
            nowait = true,
            remap = false,
        },
        {
            "<leader>fb",
            "<cmd>Telescope buffers<cr>",
            desc = "Buffer List",
            nowait = true,
            remap = false,
        },
        {
            "<leader>fr",
            "<cmd>Telescope oldfiles<cr>",
            desc = "Recent File",
            nowait = true,
            remap = false,
        },
        {
            "<leader>fw",
            "<cmd>wall<cr>",
            desc = "save all",
            nowait = true,
            remap = false,
        },
        {
            "<leader>fc",
            "<cmd>Telescope commands<cr>",
            desc = "Commands",
            nowait = true,
            remap = false,
        },
        {
            "<leader>fq",
            "<cmd>wqall<cr>",
            desc = "save all and quit",
            nowait = true,
            remap = false,
        },
        {
            "<leader>fQ",
            "<cmd>qall!<cr>",
            desc = "quit without save!!",
            nowait = true,
            remap = false,
        },
        -- t = {
        --     name = "Telescope",
        --     r = { "<cmd>Telescope registers<cr>", "Registers" },
        --     k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
        --     h = { "<cmd>Telescope command_history<cr>", "Command History" },
        --     c = { "<cmd>Telescope commands<cr>", "Commands" },
        --     m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
        --     C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
        --     ["l"] = { "<cmd>Telescope resume<cr>", "Last Search" },
        --     ["?"] = { "<cmd>Telescope help_tags<cr>", "Help" },
        -- },
        { "<leader>t", group = "Telescope", nowait = true, remap = false },
        {
            "<leader>tr",
            "<cmd>Telescope registers<cr>",
            desc = "Registers",
            nowait = true,
            remap = false,
        },
        {
            "<leader>tk",
            "<cmd>Telescope keymaps<cr>",
            desc = "Keymaps",
            nowait = true,
            remap = false,
        },
        {
            "<leader>th",
            "<cmd>Telescope command_history<cr>",
            desc = "Command History",
            nowait = true,
            remap = false,
        },
        {
            "<leader>tc",
            "<cmd>Telescope commands<cr>",
            desc = "Commands",
            nowait = true,
            remap = false,
        },
        {
            "<leader>tm",
            "<cmd>Telescope man_pages<cr>",
            desc = "Man Pages",
            nowait = true,
            remap = false,
        },
        {
            "<leader>tC",
            "<cmd>Telescope colorscheme<cr>",
            desc = "Colorscheme",
            nowait = true,
            remap = false,
        },
        {
            "<leader>tl",
            "<cmd>Telescope resume<cr>",
            desc = "Last Search",
            nowait = true,
            remap = false,
        },
        {
            "<leader>t?",
            "<cmd>Telescope help_tags<cr>",
            desc = "Help",
            nowait = true,
            remap = false,
        },
        -- g = {
        --     name = "Git",
        --     g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
        --     j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
        --     k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
        --     -- l = { "<cmd>GitBlameToggle<cr>", "Blame" },
        --     p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
        --     r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
        --     R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
        --     s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
        --     u = {
        --         "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        --         "Undo Stage Hunk",
        --     },
        --     o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        --     b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        --     c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        -- },
        { "<leader>g", group = "Git", nowait = true, remap = false },
        {
            "<leader>gg",
            "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
            desc = "Lazygit",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gj",
            "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
            desc = "Next Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gk",
            "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
            desc = "Prev Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gp",
            "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
            desc = "Preview Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gr",
            "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
            desc = "Reset Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gR",
            "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
            desc = "Reset Buffer",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gs",
            "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
            desc = "Stage Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gu",
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            desc = "Undo Stage Hunk",
            nowait = true,
            remap = false,
        },
        {
            "<leader>go",
            "<cmd>Telescope git_status<cr>",
            desc = "Open changed file",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gb",
            "<cmd>Telescope git_branches<cr>",
            desc = "Checkout branch",
            nowait = true,
            remap = false,
        },
        {
            "<leader>gc",
            "<cmd>Telescope git_commits<cr>",
            desc = "Checkout commit",
            nowait = true,
            remap = false,
        },

        -- ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
        -- b = { "<cmd>JABSOpen<cr>", "Buffers" },
        -- ["b"] = {
        --   "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        --   "Buffers",
        -- },
        -- ["w"] = { "<cmd>w<CR>", "Write" },
        -- ["h"] = { "<cmd>nohlsearch<CR>", "No HL" },
        -- ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },

        -- :lua require'lir.float'.toggle()
        -- ["f"] = {
        --   "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
        --   "Find files",
        -- },
        -- ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
        -- ["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
        -- ["R"] = { '<cmd>lua require("renamer").rename()<cr>', "Rename" },
        -- ["z"] = { "<cmd>ZenMode<cr>", "Zen" },

        -- s = {
        --   name = "Split",
        --   s = { "<cmd>split<cr>", "HSplit" },
        --   v = { "<cmd>vsplit<cr>", "VSplit" },
        -- },

        -- r = {
        --   name = "Replace",
        --   r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
        --   w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
        --   f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
        -- },

        -- d = {
        --   name = "Debug",
        --   b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Breakpoint" },
        --   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
        --   i = { "<cmd>lua require'dap'.step_into()<cr>", "Into" },
        --   o = { "<cmd>lua require'dap'.step_over()<cr>", "Over" },
        --   O = { "<cmd>lua require'dap'.step_out()<cr>", "Out" },
        --   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Repl" },
        --   l = { "<cmd>lua require'dap'.run_last()<cr>", "Last" },
        --   u = { "<cmd>lua require'dapui'.toggle()<cr>", "UI" },
        --   x = { "<cmd>lua require'dap'.terminate()<cr>", "Exit" },
        -- },

        -- nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
        -- nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
        -- require("dapui").open()
        -- require("dapui").close()
        -- require("dapui").toggle()

        -- l = {
        --     name = "LSP",
        --
        --     -- Code Action
        --     -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        --     a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
        --
        --     -- d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
        --
        --     f = { "<cmd>Lspsaga finder<cr>", "Finder" },
        --     -- f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
        --     -- F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },
        --
        --     i = { "<cmd>LspInfo<cr>", "Info" },
        --     I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
        --     j = {
        --         "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
        --         "Next Diagnostic",
        --     },
        --     k = {
        --         "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
        --         "Prev Diagnostic",
        --     },
        --     l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
        --
        --     -- o = { "<cmd>SymbolsOutline<cr>", "Outline" },
        --     o = { "<cmd>Lspsaga outline<cr>", "Outline" },
        --
        --     q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
        --
        --     -- r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
        --     r = { "<cmd>Lspsaga rename<cr>", "Rename" },
        --
        --     R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },
        --
        --     s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
        --     S = {
        --         "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        --         "Workspace Symbols",
        --     },
        --
        --     -- t = { '<cmd>lua require("functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
        --     t = { "<cmd>Lspsaga term_toggle<cr>", "Terminal" },
        --
        --     -- w = {
        --     --     "<cmd>Telescope lsp_workspace_diagnostics<cr>",
        --     --     "Workspace Diagnostics",
        --     -- },
        --     w = { "<cmd>Lspsaga winbar_toggle<cr>", "Winbar" },
        -- },
        { "<leader>l", group = "LSP", nowait = true, remap = false },
        {
            "<leader>la",
            "<cmd>Lspsaga code_action<cr>",
            desc = "Code Action",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lf",
            "<cmd>Lspsaga finder<cr>",
            desc = "Finder",
            nowait = true,
            remap = false,
        },
        {
            "<leader>li",
            "<cmd>LspInfo<cr>",
            desc = "Info",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lI",
            "<cmd>LspInstallInfo<cr>",
            desc = "Installer Info",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lj",
            "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
            desc = "Next Diagnostic",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lk",
            "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
            desc = "Prev Diagnostic",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ll",
            "<cmd>lua vim.lsp.codelens.run()<cr>",
            desc = "CodeLens Action",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lo",
            "<cmd>Lspsaga outline<cr>",
            desc = "Outline",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lq",
            "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",
            desc = "Quickfix",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lr",
            "<cmd>Lspsaga rename<cr>",
            desc = "Rename",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lR",
            "<cmd>TroubleToggle lsp_references<cr>",
            desc = "References",
            nowait = true,
            remap = false,
        },
        {
            "<leader>ls",
            "<cmd>Telescope lsp_document_symbols<cr>",
            desc = "Document Symbols",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lS",
            "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
            desc = "Workspace Symbols",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lt",
            "<cmd>Lspsaga term_toggle<cr>",
            desc = "Terminal",
            nowait = true,
            remap = false,
        },
        {
            "<leader>lw",
            "<cmd>Lspsaga winbar_toggle<cr>",
            desc = "Winbar",
            nowait = true,
            remap = false,
        },

        -- s = {
        --     name = "Lspsaga",
        --     a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
        --     f = { "<cmd>Lspsaga finder<cr>", "Finder" },
        --     o = { "<cmd>Lspsaga outline<cr>", "Outline" },
        --     r = { "<cmd>Lspsaga rename<cr>", "Rename" },
        --     t = { "<cmd>Lspsaga term_toggle<cr>", "Terminal" },
        --     w = { "<cmd>Lspsaga winbar_toggle<cr>", "Winbar" },
        -- },

        -- s = {
        --   name = "Surround",
        --   ["."] = { "<cmd>lua require('surround').repeat_last()<cr>", "Repeat" },
        --   a = { "<cmd>lua require('surround').surround_add(true)<cr>", "Add" },
        --   d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" },
        --   r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" },
        --   q = { "<cmd>lua require('surround').toggle_quotes()<cr>", "Quotes" },
        --   b = { "<cmd>lua require('surround').toggle_brackets()<cr>", "Brackets" },
        -- },

        -- S = {
        --   -- name = "Session",
        --   -- s = { "<cmd>SaveSession<cr>", "Save" },
        --   -- l = { "<cmd>LoadLastSession!<cr>", "Load Last" },
        --   -- d = { "<cmd>LoadCurrentDirSession!<cr>", "Load Last Dir" },
        --   -- f = { "<cmd>Telescope sessions save_current=false<cr>", "Find Session" },
        --   name = "SnipRun",
        --   c = { "<cmd>SnipClose<cr>", "Close" },
        --   f = { "<cmd>%SnipRun<cr>", "Run File" },
        --   i = { "<cmd>SnipInfo<cr>", "Info" },
        --   m = { "<cmd>SnipReplMemoryClean<cr>", "Mem Clean" },
        --   r = { "<cmd>SnipReset<cr>", "Reset" },
        --   t = { "<cmd>SnipRunToggle<cr>", "Toggle" },
        --   x = { "<cmd>SnipTerminate<cr>", "Terminate" },
        -- },

        -- T = {
        --   name = "Treesitter",
        --   h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight" },
        --   p = { "<cmd>TSPlaygroundToggle<cr>", "Playground" },
        -- },
    }

    local vopts = {
        mode = "v", -- VISUAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }
    local vmappings = {
        -- ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
        {
            "<leader>/",
            '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>',
            desc = "Comment",
            nowait = true,
            remap = false,
            mode = "v",
        },

        -- s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
    }

    which_key.setup(setup)
    -- which_key.register(mappings, opts)
    -- which_key.register(vmappings, vopts)
    -- which_key.register(m_mappings, m_opts)
    which_key.add(mappings, opts)
    which_key.add(vmappings, vopts)
end

return M
