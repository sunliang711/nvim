local M = {}

function M.setup()
    local status_ok, session = pcall(require, "auto-session")
    if not status_ok then
        return
    end

    vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    session.setup({
        enabled = true,
        auto_restore_last_session = true,
        log_level = "error",
        root_dir = vim.fn.stdpath("data") .. "/sessions/",

        session_lens = {
            -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
            buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
            load_on_setup = true,
            theme_conf = { border = true },
            previewer = false,
            auto_session_suppress_dirs = { "~/", "~/Workspace", "~/Downloads", "/" },
        },
        -- Set mapping for searching a session.
        -- ⚠️ This will only work if Telescope.nvim is installed
        vim.keymap.set("n", "<Leader>a", require("auto-session.session-lens").search_session, {
            noremap = true,
        }),
    })
end

return M
