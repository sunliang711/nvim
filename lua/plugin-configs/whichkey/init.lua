local M = {}

function M.setup()
    local status_ok, which_key = pcall(require, "which-key")
    if not status_ok then
        return
    end

    local setup = {
        plugins = {
            marks = true,         -- shows a list of your marks on ' and `
            registers = true,     -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = false,      -- adds help for motions
                text_objects = false, -- help for text objects triggered after entering an operator
                windows = true,       -- default bindings on <c-w>
                nav = true,           -- misc bindings to work with windows
                z = true,             -- bindings for folds, spelling and others prefixed with z
                g = true,             -- bindings for prefixed with g
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
            scroll_up = "<c-u>",   -- binding to scroll up inside the popup
        },
        window = {
            border = "rounded",       -- none, single, double, shadow
            position = "bottom",      -- bottom, top
            margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
        },
        layout = {
            height = { min = 4, max = 25 },                                           -- min and max height of the columns
            width = { min = 20, max = 50 },                                           -- min and max width of the columns
            spacing = 3,                                                              -- spacing between columns
            align = "center",                                                         -- align columns left, center or right
        },
        ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = false,                                                            -- show help message on the command line when the popup is visible
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
        mode = "n",     -- NORMAL mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
    }

    local m_opts = {
        mode = "n",     -- NORMAL mode
        prefix = "m",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
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
        [";"] = { "<cmd>Alpha<cr>", "Dashboard" },
        ["e"] = { "<cmd>NvimTreeToggle<cr>", "File Explorer" },
        ["/"] = { '<cmd>lua require("Comment.api").toggle_current_linewise()<CR>', "Comment" },
        p = {
            name = "Package Manage",
            s = { "<cmd>Lazy sync<cr>", "sync plugins" },
            l = { "<cmd>Lazy log<cr>", "lazy log" },
            p = { "<cmd>Lazy show<cr>", "lazy show" },
            b = { "<cmd>Lazy build<cr>", "lazy build" },
        },
        o = {
            name = "Options",
            w = { '<cmd>lua require("functions").toggle_option("wrap")<cr>', "Wrap" },
            r = { '<cmd>lua require("functions").toggle_option("relativenumber")<cr>', "Relative" },
            l = { '<cmd>lua require("functions").toggle_option("cursorline")<cr>', "Cursorline" },
            c = { '<cmd>lua require("functions").toggle_option("cursorcolumn")<cr>', "Cursorcolumn" },
            s = { '<cmd>lua require("functions").toggle_option("spell")<cr>', "Spell" },
            D = { "<cmd>set background=dark<cr>", "set background to dark" },
            L = { "<cmd>set background=light<cr>", "set background to light" },
            C = { "<cmd>checkhealth<cr>", "Check Health" },
            e = { "<cmd>edit ~/.config/nvim/init.lua<cr>", "edit init.lua" },
            -- t = { '<cmd>lua require("functions").toggle_tabline()<cr>', "Tabline" },
        },
        h = {
            { "<cmd>nohlsearch<cr>", "No Highlight" },
        },
        b = {
            name = "Buffer manage",
            h = { "<cmd>BufferLineCloseLeft<cr>", "close all to the left" },
            l = { "<cmd>BufferLineCloseRight<cr>", "close all to the right" },
            o = { "<cmd>BufferLineCloseOthers<cr>", "close all other tabs" },
            c = { "<cmd>BufferLinePickClose<cr>", "pick buffer to close" },

            p = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
            n = { "<cmd>BufferLineCycleNext<cr>", "next" },

            b = { "<cmd>BufferLineCyclePrev<cr>", "previous" },
            j = { "<cmd>BufferLinePick<cr>", "jump" },

        },
        w = {
            name = "Window and Tab",
            h = { "<c-w>h", "left window" },
            j = { "<c-w>j", "bottom window" },
            k = { "<c-w>k", "top window" },
            l = { "<c-w>l", "right window" },
            ["["] = { "<cmd>bprevious<cr>", "left tab" },
            ["]"] = { "<cmd>bnext<cr>", "right tab" },
            ["-"] = { "<cmd>split<cr>", "HSplit" },
            ["|"] = { "<cmd>vsplit<cr>", "VSplit" },
            q = { "<cmd>q<cr>", "Close Window" },
            f = { "<cmd>NvimTreeFindFile<cr>", "focus file in nvim tree" },
        },
        q = {
            name = "Quickfix",
            n = { "<cmd>cnext<cr>", "next quickfix location" },
            p = { "<cmd>cprevious<cr>", "previous quickfix location" },
            c = { "<cmd>cclose<cr>", "close quickfix window" },

            j = { "<cmd>cnext<cr>", "next quickfix location" },
            k = { "<cmd>cprevious<cr>", "previous quickfix location" },
            q = { "<cmd>cclose<cr>", "close quickfix window" },
        },
        -- ["q"] = { '<cmd>lua require("functions").smart_quit()<CR>', "Quit" },
        T = {
            name = "Terminal",
            t = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
            h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal Terminal" },
            v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical Terminal" },
        },
        f = {
            name = "File",

            F = { "<cmd>Telescope find_files<cr>", "Find Files (With Previewer)" },
            f = {
                "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
                "Find Files",
            },

            t = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
            b = { "<cmd>Telescope buffers<cr>", "Buffer List" },
            r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
            -- i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
            w = { "<cmd>wall<cr>", "save all" },
            c = { "<cmd>Telescope commands<cr>", "Commands" },

            q = { "<cmd>wqall<cr>", "save all and quit" },
            Q = { "<cmd>qall!<cr>", "quit without save!!" },
        },
        t = {
            name = "Telescope",
            r = { "<cmd>Telescope registers<cr>", "Registers" },
            k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
            h = { "<cmd>Telescope command_history<cr>", "Command History" },
            c = { "<cmd>Telescope commands<cr>", "Commands" },
            m = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
            C = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
            ["l"] = { "<cmd>Telescope resume<cr>", "Last Search" },
            ["?"] = { "<cmd>Telescope help_tags<cr>", "Help" },
        },
        g = {
            name = "Git",
            g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
            j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
            k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
            -- l = { "<cmd>GitBlameToggle<cr>", "Blame" },
            p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
            r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
            R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
            s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
            u = {
                "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
                "Undo Stage Hunk",
            },
            o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
            b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
            c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
            -- d = {
            --   "<cmd>Gitsigns diffthis HEAD<cr>",
            --   "Diff",
            -- },
            -- G = {
            --     name = "Gist",
            --     a = { "<cmd>Gist -b -a<cr>", "Create Anon" },
            --     d = { "<cmd>Gist -d<cr>", "Delete" },
            --     f = { "<cmd>Gist -f<cr>", "Fork" },
            --     g = { "<cmd>Gist -b<cr>", "Create" },
            --     l = { "<cmd>Gist -l<cr>", "List" },
            --     p = { "<cmd>Gist -b -p<cr>", "Create Private" },
            -- },
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

        l = {
            name = "LSP",

            -- Code Action
            -- a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
            a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },

            -- d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },

            f = { "<cmd>Lspsaga finder<cr>", "Finder" },
            -- f = { "<cmd>lua vim.lsp.buf.format({ async = true })<cr>", "Format" },
            -- F = { "<cmd>LspToggleAutoFormat<cr>", "Toggle Autoformat" },

            i = { "<cmd>LspInfo<cr>", "Info" },
            I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
            j = {
                "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>",
                "Next Diagnostic",
            },
            k = {
                "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>",
                "Prev Diagnostic",
            },
            l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },

            -- o = { "<cmd>SymbolsOutline<cr>", "Outline" },
            o = { "<cmd>Lspsaga outline<cr>", "Outline" },

            q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },

            -- r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
            r = { "<cmd>Lspsaga rename<cr>", "Rename" },

            R = { "<cmd>TroubleToggle lsp_references<cr>", "References" },

            s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
            S = {
                "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
                "Workspace Symbols",
            },

            -- t = { '<cmd>lua require("functions").toggle_diagnostics()<cr>', "Toggle Diagnostics" },
            t = { "<cmd>Lspsaga term_toggle<cr>", "Terminal" },

            -- w = {
            --     "<cmd>Telescope lsp_workspace_diagnostics<cr>",
            --     "Workspace Diagnostics",
            -- },
            w = { "<cmd>Lspsaga winbar_toggle<cr>", "Winbar" },
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
        mode = "v",     -- VISUAL mode
        prefix = "<leader>",
        buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true,  -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true,  -- use `nowait` when creating keymaps
    }
    local vmappings = {
        ["/"] = { '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>', "Comment" },
        -- s = { "<esc><cmd>'<,'>SnipRun<cr>", "Run range" },
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
    which_key.register(vmappings, vopts)
    -- which_key.register(m_mappings, m_opts)
end

return M
