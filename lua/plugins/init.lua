local M = {}

function M.setup()
    local F = require "functions"

    -- load plugin manager
    require "plugins.packer".setup()

    -- load notify first to use vim.notify function
    F.load_p_config("notify")
    -- load impatient second to imporve startup time for neovim
    F.load_p_config("impatient")

    F.load_p_config("alpha")
    F.load_p_config("bufferline")
    F.load_p_config("autopairs")
    F.load_p_config("cmp")
    F.load_p_config("colorscheme")
    F.load_p_config("comment")
    F.load_p_config("gitsigns")
    F.load_p_config("lualine")
    F.load_p_config("neoscroll")
    F.load_p_config("nvimtree")
    F.load_p_config("surround")
    F.load_p_config("toggleterm")
    F.load_p_config("hop")
    F.load_p_config("telescope")

    F.load_p_config("treesitter")
    F.load_p_config("lsp")

    F.load_p_config("whichkey")

    vim.notify("All plugins loaded", "info")
end

return M
