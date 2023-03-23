local M = {}

function M.setup()
    local status_gruvbox, gruvbox = pcall(require, "gruvbox")
    if not status_gruvbox then
        vim.notify("load gruvbox failed")
        return
    end

    gruvbox.setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
            strings = true,
            operators = true,
            comments = true,
        },
        strikethrough = true,
        invert_selection = false,
        invert_signs = false,
        invert_tabline = false,
        invert_intend_guides = false,
        inverse = true, -- invert background for search, diffs, statuslines and errors
        contrast = "",  -- can be "hard", "soft" or empty string
        palette_overrides = {},
        overrides = {},
        dim_inactive = false,
        transparent_mode = false,
    })

    vim.cmd("colorscheme gruvbox")

    -- local colorscheme = "gruvbox"
    -- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
    -- if not status_ok then
    --     vim.notify("Colorscheme " .. colorscheme .. " not found!")
    --     return
    -- end
end

return M
