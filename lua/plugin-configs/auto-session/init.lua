local M = {}

function M.setup()
    local status_ok, session = pcall(require, "auto-session")
    if not status_ok then
        return
    end

    session.setup({
        log_level = "error",
        auto_session_enable_last_session = false,
        auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
        auto_session_enabled = true,
    })
end

return M
