local M = {}

function M.setup()
    local status_ok, hop = pcall(require, "hop")
    if not status_ok then
        return
    end

    hop.setup()

    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_set_keymap

    keymap('n', 'gw', "<cmd>HopWord<cr>", opts)
    keymap('n', 'gl', "<cmd>HopLine<cr>", opts)
    keymap('n', 'gp', "<cmd>HopPattern<cr>", opts)

    -- keymap("n", "]b", "<cmd>bnext<cr>", opts)
    keymap('n', 'f',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
        , {})
    keymap('n', 'F',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
        , {})
    keymap('o', 'f',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
        , {})
    keymap('o', 'F',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>"
        , {})

    -- maybe wrong config
    keymap('', 't',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>"
        , {})
    keymap('', 'T',
        "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>"
        , {})

    keymap('n', '<leader>e',
        "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
    keymap('v', '<leader>e',
        "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END })<cr>", {})
    keymap('o', '<leader>e',
        "<cmd> lua require'hop'.hint_words({ hint_position = require'hop.hint'.HintPosition.END, inclusive_jump = true })<cr>"
        , {})
end

return M
