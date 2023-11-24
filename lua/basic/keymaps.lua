local M = {}

function M.setup()
    local opts = { noremap = true, silent = true }

    local keymap = vim.api.nvim_set_keymap

    keymap("", "<Space>", "<Nop>", opts)

    vim.g.mapleader = ","
    vim.g.maplocalleader = ","

    -- Modes
    -- 	normal_mode = "n"
    -- 	insert_mode = "i"
    -- 	visual_mode = "v"
    -- 	visual_block_mode = "x"
    -- 	term_mode = "t"
    -- 	command_mode = "c"

    -- Normal --
    -- nav window
    keymap("n", "<C-h>", "<C-w>h", opts)
    keymap("n", "<C-j>", "<C-w>j", opts)
    keymap("n", "<C-k>", "<C-w>k", opts)
    keymap("n", "<C-l>", "<C-w>l", opts)
    -- nav buffer
    keymap("n", "]b", "<cmd>bnext<cr>", opts)
    keymap("n", "[b", "<cmd>bprevious<cr>", opts)

    -- keymap("n", "<esc><esc>", "<cmd>nohlsearch<cr>", opts)
    keymap("n", "<up>", "<cmd> resize +2<cr>", opts)
    keymap("n", "<down>", "<cmd>resize -2<cr>", opts)
    keymap("n", "<left>", "<cmd>vertical resize -2<cr>", opts)
    keymap("n", "<right>", "<cmd>vertical resize +2<cr>", opts)
end

return M
