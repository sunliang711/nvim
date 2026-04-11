local M = {}

function M.setup()
    local status_ok, session = pcall(require, "auto-session")
    if not status_ok then
        return
    end

    local telescope_status_ok, telescope = pcall(require, "telescope")
    if telescope_status_ok then
        pcall(telescope.load_extension, "session-lens")
    end

    -- 不恢复 session 保存时的 cwd，避免启动于项目根时被窗口级 lcd 带偏
    vim.o.sessionoptions = "blank,buffers,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    local opts = {
        enabled = true,
        auto_restore_last_session = false,
        log_level = "error",
        root_dir = vim.fn.stdpath("data") .. "/sessions/",
    }

    if telescope_status_ok then
        -- telescope 可用时再启用 session-lens，避免关闭 telescope 后启动报错
        opts.session_lens = {
            -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
            buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
            load_on_setup = true,
            picker = "telescope",
            theme_conf = { border = true },
            previewer = false,
            auto_session_suppress_dirs = { "~/", "~/Workspace", "~/Downloads", "/" },
        }
    end

    session.setup(opts)

    vim.keymap.set("n", "<Leader>a", "<cmd>AutoSession search<CR>", {
        noremap = true,
        silent = true,
    })
end

return M
