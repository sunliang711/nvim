local M = {}

function M.setup()
    local status_ok, autopairs = pcall(require, "nvim-autopairs")
    if not status_ok then
        --vim.notify("Load autopais failed")
        return
    end

    -- autopairs.setup({ map_cr = true })
    autopairs.setup {
        fast_wrap = {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0, -- Offset from pattern match
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    }

    -- if PLUGINS.nvim_cmp.enabled then
    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
    local cmp_status_ok, cmp = pcall(require, "cmp")
    if not cmp_status_ok then
        return
    end
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
    -- end
end

return M
