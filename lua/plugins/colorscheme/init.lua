local M = {}

function M.setup()
    local colorscheme = "gruvbox"

    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    if not status_ok then
        vim.notify("Colorscheme " .. colorscheme .. " not found!")
        return
    end
end

return M
